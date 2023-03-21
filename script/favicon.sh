#!/bin/bash

# Make a circular favicon from your GitHub avatar
#
#   ./favicon.sh username

set -eu

if ! command -v convert >/dev/null; then
  echo "error: ImageMagick isn't installed." >&2
  exit 1
fi

if [ $# -eq 0 ]; then
  echo "error: No GitHub username provided." >&2
  exit 1
fi

curl -L "https://github.com/$1.png?size=32" -o input.jpg

convert input.jpg \
  -gravity Center \
  \( -size 32x32 \
    xc:Black \
    -fill White \
    -draw 'circle 16 16 16 1' \
    -alpha Copy \
  \) -compose CopyOpacity -composite \
  -trim favicon.ico