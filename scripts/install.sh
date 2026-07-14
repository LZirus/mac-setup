#!/usr/bin/env bash
# Resilient installer: install each Brewfile entry individually so one failure
# never blocks the rest. Retries once on failure (handles transient downloads).
# Records failures to install_fail.log. mas apps handled separately (need App Store login).
# Run from anywhere: operates on the Brewfile at the repo root.
cd "$(dirname "$0")/.." || exit 1
: > install_fail.log
: > install_ok.log

try() {  # $1 = "formula"|"cask", $2 = name
  local kind="$1" name="$2" base="${2##*/}" flag=""
  [ "$kind" = "cask" ] && flag="--cask"
  if brew list $flag "$base" >/dev/null 2>&1; then echo "skip  $name"; return 0; fi
  if brew install $flag "$name" </dev/null >>brew_run.log 2>&1; then
    echo "OK    $name"; echo "$name" >> install_ok.log
  else
    echo "retry $name"
    if brew install $flag "$name" </dev/null >>brew_run.log 2>&1; then
      echo "OK    $name (retry)"; echo "$name" >> install_ok.log
    else
      echo "FAIL  $kind $name"; echo "$kind $name" >> install_fail.log
    fi
  fi
}

echo "==== FORMULAE ===="
grep -E '^brew "' Brewfile | sed -E 's/^brew "([^"]+)".*/\1/' | while read -r n; do try formula "$n"; done
echo "==== CASKS ===="
grep -E '^cask "' Brewfile | sed -E 's/^cask "([^"]+)".*/\1/' | while read -r n; do try cask "$n"; done

echo "==== SUMMARY ===="
echo "installed OK: $(wc -l < install_ok.log | tr -d ' ')"
echo "failed:       $(wc -l < install_fail.log | tr -d ' ')"
[ -s install_fail.log ] && { echo "--- failures ---"; cat install_fail.log; }
echo "DONE"
