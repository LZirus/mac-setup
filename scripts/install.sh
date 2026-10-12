#!/usr/bin/env bash
# Resilient installer: install each Brewfile entry individually so one failure
# never blocks the rest. Retries once on failure (handles transient downloads).
# Records failures to install_fail.log. mas apps handled separately (need App Store login).
# Run from anywhere: operates on the Brewfile at the repo root.
cd "$(dirname "$0")/.." || exit 1

if [ ! -f Brewfile ] || [ ! -r Brewfile ]; then
  echo "ERROR: Brewfile not found or not readable at $(pwd)/Brewfile" >&2
  exit 1
fi
if ! command -v brew >/dev/null 2>&1; then
  echo "ERROR: Homebrew (brew) not found in PATH. Install Homebrew first." >&2
  exit 1
fi

: > install_fail.log
: > install_ok.log

try() {  # $1 = "formula"|"cask", $2 = full package name, $3 = "true"|"false" link wanted (formula only)
  local kind="$1" name="$2" want_link="${3:-false}" flag="--formula" installed=false
  [ "$kind" = "cask" ] && flag="--cask"
  if brew list $flag "$name" >/dev/null 2>&1; then
    echo "skip  $name"; installed=true
  elif brew install $flag "$name" </dev/null >>brew_run.log 2>&1; then
    echo "OK    $name"; echo "$name" >> install_ok.log; installed=true
  else
    echo "retry $name"
    if brew install $flag "$name" </dev/null >>brew_run.log 2>&1; then
      echo "OK    $name (retry)"; echo "$name" >> install_ok.log; installed=true
    else
      echo "FAIL  $kind $name"; echo "$kind $name" >> install_fail.log
    fi
  fi

  if [ "$installed" = true ] && [ "$kind" = "formula" ] && [ "$want_link" = "true" ]; then
    if brew link --formula --force "$name" >>brew_run.log 2>&1; then
      echo "OK    link $name"
    else
      echo "FAIL  link $name"; echo "link $name" >> install_fail.log
    fi
  fi
}

echo "==== FORMULAE ===="
grep -E '^[[:space:]]*brew "' Brewfile | sed -E 's/[[:space:]]+#.*$//' | while read -r line; do
  n=$(printf '%s' "$line" | sed -E 's/^[[:space:]]*brew "([^"]+)".*/\1/')
  lk="false"
  printf '%s' "$line" | grep -Eq 'link:[[:space:]]*true' && lk="true"
  try formula "$n" "$lk"
done
echo "==== CASKS ===="
grep -E '^[[:space:]]*cask "' Brewfile | sed -E 's/[[:space:]]+#.*$//' | while read -r line; do
  n=$(printf '%s' "$line" | sed -E 's/^[[:space:]]*cask "([^"]+)".*/\1/')
  try cask "$n"
done

echo "==== SUMMARY ===="
echo "installed OK: $(wc -l < install_ok.log | tr -d ' ')"
echo "failed:       $(wc -l < install_fail.log | tr -d ' ')"
[ -s install_fail.log ] && { echo "--- failures ---"; cat install_fail.log; }
echo "DONE"
[ -s install_fail.log ] && exit 1
exit 0
