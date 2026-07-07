#!/usr/bin/env python3
"""Crop chrome / letterboxing off a screenshot to isolate the useful frame.

Typical use: a user pastes a full YouTube screenshot (search bar on top, video
title caption on the bottom). Crop it down to just the video frame before using
it as a cover background.

Usage:
    crop_screenshot.py in.png out.png LEFT TOP RIGHT BOTTOM

Coordinates are pixels in the ORIGINAL image (left, top, right, bottom).
Requires Pillow (`pip install Pillow`).
"""
import sys
from PIL import Image


def main() -> None:
    if len(sys.argv) != 7:
        sys.exit("usage: crop_screenshot.py in.png out.png LEFT TOP RIGHT BOTTOM")
    src, dst = sys.argv[1], sys.argv[2]
    left, top, right, bottom = map(int, sys.argv[3:7])
    im = Image.open(src)
    print(f"orig  {im.size[0]}x{im.size[1]}")
    cropped = im.crop((left, top, right, bottom))
    cropped.save(dst)
    w, h = cropped.size
    print(f"crop  {w}x{h}  aspect {w / h:.3f}  -> {dst}")


if __name__ == "__main__":
    main()
