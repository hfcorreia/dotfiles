#!/bin/zsh

function renamer() {
  local dry_run=0

  if [[ "$1" == "--dry-run" ]]; then
    dry_run=1
    shift
  fi

  if [[ $# -lt 3 ]]; then
    echo "Usage: renamer [--dry-run] <dir> <file_pattern> <sed_expression...>"
    echo "Example: renamer --dry-run ./src '*.ts' -e 's/foo/bar/g'"
    return 1
  fi

  local dir="$1"
  local file_pattern="$2"
  shift 2
  local sed_expression=("$@")

  if [[ ! -d "$dir" ]]; then
    echo "Error: '$dir' is not a directory."
    return 1
  fi

  if [[ $dry_run -eq 1 ]]; then
    echo "Dry run: showing files that would change based on patterns:"
    for expr in "${sed_expression[@]}"; do
      if [[ "$expr" =~ s.([^/]+).([^/]*) ]]; then
        local pattern="${match[1]}"
        echo "Searching for pattern: $pattern"
        find "$dir" -type f -name "$file_pattern" -print0 | xargs -0 grep -l "$pattern"
      else
        echo "Skipping complex expression: $expr"
      fi
    done
  else
    find "$dir" -type f -name "$file_pattern" -print0 | xargs -0 sed -i '' "${sed_expression[@]}"
  fi
}

