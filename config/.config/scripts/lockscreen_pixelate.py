#!/usr/bin/env python
"""
Lockscreen pixelate filter

Obscure anything brighter/dark than a threshold.

Usage:
    lockscreen_filter <source> <target> <size>
"""

import os
import sys

from PIL import (Image, ImageDraw)

def main():


    if len(sys.argv) < 4:
        print(__doc__)
        return

    source = sys.argv[1].replace("~", os.getenv("HOME"))
    target = sys.argv[2].replace("~", os.getenv("HOME"))
    size = int(sys.argv[3].replace("~", os.getenv("HOME")))

    img = Image.open(source)
    result = img.copy()
    draw = ImageDraw.ImageDraw(result)
    pixels = img.getdata()

    for j in range(0, img.height, size):
        for i in range(0, img.width, size):
            index = j * (img.width) + i
            r, g, b = pixels[index]
            draw.rectangle((i-size,j-size, i+size, j+size), fill=pixels[index])

    result.save(target)

if __name__ == "__main__":
    main()
