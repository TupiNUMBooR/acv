#!/usr/bin/env ash
set -euo pipefail

# av1 10bit crf40
ffmpeg -i "$1" -map 0 -c copy -c:v libsvtav1 -crf 40 -preset 5 -movflags faststart -pix_fmt yuv420p10le "${2%.*}.kf01m1.webm"
