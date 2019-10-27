#!/usr/bin/env bash

set -eo pipefail

# 1. Create temporary lockfile = ImageOptim.lock.tmp
# 2. Compare ImageOptim.lock.temp with ImageOptim.lock
# 3. Apply imageoptim-cli to all the new or modified images
# 4. Create new ImageOptim.lock

LOCKFILE="imageoptim.lock"

TEMP_LOCKFILE=$(mktemp)
trap 'rm -f $TEMP_LOCKFILE; exit' EXIT

ensure_imageoptim() {
  if ! hash imageoptim 2>/dev/null; then
    echo
    echo "imageoptim-cli is required."
    echo "  (see: https://imageoptim.com/command-line.html)"
    echo "  (install: \`npm install -g imageoptim-cli\`)"
    return 1
  fi
}

generate_file_list() {
  local files

  if [[ -f "$LOCKFILE" ]]; then
    files="$(sort "$LOCKFILE" "$TEMP_LOCKFILE" | uniq -u)"
  else
    files="$(cat "$TEMP_LOCKFILE")"
  fi

  echo "$files" | sed -E 's/^[[:space:]]+[0-9]+[[:space:]]+//g'
}

generate_lockfile() {
  find . -name '*.png' -type f -not -path "./Pods*" -exec wc -c {} \; | sort -r
}

main() {
  generate_lockfile > "$TEMP_LOCKFILE"
  files_to_optimize="$(generate_file_list)"

  if [[ -n "$files_to_optimize" ]]; then
    echo "$files_to_optimize" | imageoptim
    generate_lockfile > "$LOCKFILE"
    echo "Finished optimizing."
  else
    echo "Optimization not needed."
  fi
}

if ensure_imageoptim; then
  main
fi
