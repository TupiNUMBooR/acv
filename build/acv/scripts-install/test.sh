#!/usr/bin/env ash
set -euo pipefail

if [[ "$1" = *fail ]]; then
  echo "fail copying $1 to $2"
  exit 1
else
  echo "copying $1 to $2"
  cp "$1" "$2"
fi
