#!/usr/bin/env ash
set -euo pipefail

magick "$1" "${2%.*}.avif"
