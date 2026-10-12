"""Offline regression tests: the installer only sees a simulated Homebrew."""

from pathlib import Path
import subprocess
import tempfile
import unittest


INSTALLER = Path(__file__).resolve().parents[1] / "scripts" / "install.sh"
BREW_STUB = r'''#!/bin/sh
printf '%s\n' "$*" >> "$BREW_TEST_CALLS"
for argument in "$@"; do name="$argument"; done
case "$1" in
  list)
    [ "$name" = "$BREW_TEST_INSTALLED" ]
    ;;
  install)
    case "$name" in
      broken) exit 1 ;;
      flaky)
        if [ ! -f "$BREW_TEST_RETRY_MARKER" ]; then
          : > "$BREW_TEST_RETRY_MARKER"
          exit 1
        fi
        ;;
    esac
    exit 0
    ;;
  link)
    if [ "$name" = postgresql@17 ]; then
      case " $* " in
        *" --force "*) ;;
        *) echo "postgresql@17 is keg-only; --force required" >&2; exit 1 ;;
      esac
    fi
    [ "$name" != "link-broken" ]
    ;;
  *) echo "Unexpected mock brew command: $*" >&2; exit 64 ;;
esac
'''


class InstallTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="mac-setup-test-")
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        (self.root / "scripts").mkdir()
        (self.root / "bin").mkdir()
        self.script = self.root / "scripts" / "install.sh"
        self.script.write_bytes(INSTALLER.read_bytes())
        self.brew = self.root / "bin" / "brew"
        self.brew.write_text(BREW_STUB)
        self.brew.chmod(0o755)
        self.environment = {
            "PATH": f"{self.root / 'bin'}:/usr/bin:/bin",
            "HOME": str(self.root),
            "LC_ALL": "C",
            "BREW_TEST_CALLS": str(self.root / "calls.log"),
            "BREW_TEST_RETRY_MARKER": str(self.root / "retry.marker"),
            "BREW_TEST_INSTALLED": "",
        }

    def run_installer(self, brewfile=None):
        if brewfile is not None:
            (self.root / "Brewfile").write_text(brewfile)
        return subprocess.run(
            ["/bin/bash", str(self.script)],
            cwd="/private/tmp" if Path("/private/tmp").exists() else "/tmp",
            env=self.environment,
            capture_output=True,
            text=True,
            timeout=10,
        )

    def calls(self):
        path = self.root / "calls.log"
        return path.read_text().splitlines() if path.exists() else []

    def seed_logs(self):
        for name in ("install_fail.log", "install_ok.log", "brew_run.log"):
            (self.root / name).write_text("previous run\n")

    def assert_logs_preserved(self):
        for name in ("install_fail.log", "install_ok.log", "brew_run.log"):
            self.assertEqual((self.root / name).read_text(), "previous run\n")

    def test_successful_formula_and_cask(self):
        result = self.run_installer('brew "good"\ncask "good-app"\n')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual((self.root / "install_fail.log").read_text(), "")
        self.assertIn("good\n", (self.root / "install_ok.log").read_text())
        self.assertIn("good-app\n", (self.root / "install_ok.log").read_text())
        self.assertTrue(any(call.startswith("install --cask ") for call in self.calls()))

    def test_failure_retries_once_and_continues(self):
        result = self.run_installer('brew "broken"\nbrew "good"\ncask "good-app"\n')
        self.assertNotEqual(result.returncode, 0)
        attempts = [call for call in self.calls() if call.startswith("install ") and call.endswith(" broken")]
        self.assertEqual(len(attempts), 2)
        self.assertIn("broken", (self.root / "install_fail.log").read_text())
        self.assertIn("good-app", (self.root / "install_ok.log").read_text())

    def test_transient_failure_succeeds_after_retry(self):
        result = self.run_installer('brew "flaky"\n')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual((self.root / "install_fail.log").read_text(), "")
        self.assertEqual(len([call for call in self.calls() if call.startswith("install ")]), 2)

    def test_missing_brewfile_preserves_previous_logs(self):
        self.seed_logs()
        result = self.run_installer()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Brewfile", result.stdout + result.stderr)
        self.assert_logs_preserved()
        self.assertEqual(self.calls(), [])

    def test_directory_is_not_a_brewfile(self):
        (self.root / "Brewfile").mkdir()
        self.seed_logs()
        self.assertNotEqual(self.run_installer().returncode, 0)
        self.assert_logs_preserved()

    def test_missing_homebrew_preserves_previous_logs(self):
        self.brew.unlink()
        self.seed_logs()
        result = self.run_installer('brew "good"\n')
        self.assertNotEqual(result.returncode, 0)
        self.assert_logs_preserved()

    def test_link_requested_for_new_formula(self):
        result = self.run_installer('brew "postgresql@17", link: true\n')
        self.assertEqual(result.returncode, 0, result.stderr)
        links = [call for call in self.calls() if call.startswith("link ")]
        self.assertEqual(len(links), 1)
        self.assertIn("--force", links[0])
        self.assertTrue(links[0].endswith(" postgresql@17"))
        self.assertNotIn("--overwrite", links[0])

    def test_link_requested_for_already_installed_formula(self):
        self.environment["BREW_TEST_INSTALLED"] = "postgresql@17"
        result = self.run_installer('brew "postgresql@17", link: true\n')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertFalse(any(call.startswith("install ") for call in self.calls()))
        self.assertTrue(any(call.startswith("link ") for call in self.calls()))

    def test_link_failure_is_logged_and_processing_continues(self):
        result = self.run_installer('brew "link-broken", link: true\nbrew "good"\n')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("link-broken", (self.root / "install_fail.log").read_text())
        self.assertIn("good", (self.root / "install_ok.log").read_text())

    def test_indentation_and_comment_do_not_request_link(self):
        result = self.run_installer('  brew "good" # example: link: true\n  cask "good-app"\n')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("good-app", (self.root / "install_ok.log").read_text())
        self.assertFalse(any(call.startswith("link ") for call in self.calls()))

    def test_full_tap_name_and_explicit_package_type(self):
        self.environment["BREW_TEST_INSTALLED"] = "owner/tap/good"
        result = self.run_installer('brew "owner/tap/good"\ncask "good-app"\n')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("list --formula owner/tap/good", self.calls())
        self.assertIn("list --cask good-app", self.calls())
        self.assertFalse(any(call.startswith("install ") and call.endswith(" owner/tap/good") for call in self.calls()))


if __name__ == "__main__":
    unittest.main()
