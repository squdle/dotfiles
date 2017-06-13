#!/usr/bin/env python
"""
Lockscreen filter

Obscure anything brighter/dark than a threshold.

Usage:
    lockscreen_filter <source> <target> [ threshold ] [ --invert ]
"""

import os
import sys

from PIL import (Image, ImageDraw)

def main():
    size_w = 10
    size_h = 10
    fill = (0, 0, 0)
    step_i = 2
    step_j = 2
    threshold = 200

    condition = lambda r, g, b : (r+g+b) / 3 > threshold

    if len(sys.argv) < 3:
        print(__doc__)
        return
    if len(sys.argv) >= 4:
        threshold = int(sys.argv[3])
        condition = lambda r, g, b : (r+g+b) / 3 < threshold
    if len(sys.argv) == 5:
        fill = (255, 255, 255)

    source = sys.argv[1].replace("~", os.getenv("HOME"))
    target = sys.argv[2].replace("~", os.getenv("HOME"))

    img = Image.open(source)
    result = img.copy()
    draw = ImageDraw.ImageDraw(result)
    pixels = img.getdata()

    for j in range(0, img.height, step_j):
        for i in range(0, img.width, step_i):
            index = j * (img.width) + i
            r, g, b = pixels[index]
            if condition(r, g, b):
                draw.rectangle((i-size_w,j-size_h, i+size_w, j+size_h), fill=fill)

    result.save(target)

if __name__ == "__main__":
    main()
