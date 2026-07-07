#!/usr/bin/env bash
# macOS: save the image currently on the clipboard to a PNG file.
# Useful when the user copies a video frame / screenshot to use as a cover
# background (pasted images in chat are NOT on disk; a clipboard copy is).
#
# Usage: ./clipboard_to_png.sh out.png
# Tip: `osascript -e 'clipboard info'` shows whether an image is on the clipboard.
set -euo pipefail
OUT="${1:?usage: clipboard_to_png.sh out.png}"
osascript \
  -e 'set thePng to (the clipboard as «class PNGf»)' \
  -e "set fp to open for access POSIX file \"$OUT\" with write permission" \
  -e 'set eof fp to 0' \
  -e 'write thePng to fp' \
  -e 'close access fp'
echo "saved clipboard image -> $OUT"
