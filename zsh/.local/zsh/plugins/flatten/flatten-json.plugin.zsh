#!/bin/zsh

function flatten_json() {
  # Check if a JSON file path is provided
  if [[ -z "$1" || ! -f "$1" ]]; then
    echo "Usage: flatten_json <path_to_json_file>"
    return 1
  fi

  # Determine the correct Python alias
  python_alias=$(command -v python3 || command -v python)
  if [[ -z "$python_alias" ]]; then
    echo "Error: Python is not installed or not available in PATH."
    return 1
  fi

  # Run the Python script
  "$python_alias" - <<EOF
import json
import sys

def flatten(obj, prefix=""):
    if isinstance(obj, list):
      return [flatten(item) for i, item in enumerate(obj)]
    else:
      items = {}
      for key, value in obj.items():
          new_key = f"{prefix}{key}" if prefix else key
          if isinstance(value, dict):
              items.update(flatten(value, f"{new_key}."))
          elif isinstance(value, list):
              items[new_key] = ", ".join(map(str, value))
          else:
              items[new_key] = value
      return items

try:
    with open("$1") as f:
        data = json.load(f)
    print(json.dumps(flatten(data), indent=2))
except Exception as e:
    print(f"Error: {e}", file=sys.stderr)
    sys.exit(1)
EOF
}

