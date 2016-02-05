#!/usr/bin/env python3

# Slightly modified python script from https://github.com/boramalper/himawaripy

from io import BytesIO
from json import loads
from time import strptime, strftime
from subprocess import call
from os import makedirs
from os.path import expanduser, split
from urllib.request import urlopen

from PIL import Image

from multiprocessing import Pool, cpu_count, Value
from itertools import product

level = 2
width = 550
height = 550

output_file = expanduser("~/.wallpaper-himawari-latest.png")
url_format = "http://himawari8.nict.go.jp/img/D531106/{}d/{}/{}_{}_{}.png"
url_json = "http://himawari8-dl.nict.go.jp/himawari8/img/D531106/latest.json"

counter = None


def download_chunk(args):
    global counter

    x, y, latest = args

    with urlopen(url_format.format(level, width, strftime("%Y/%m/%d/%H%M%S", latest), x, y)) as tile_w:
        tiledata = tile_w.read()

    with counter.get_lock(): counter.value += 1

    return (x, y,tiledata)


def main():
    global counter

    with urlopen(url_json) as latest_json:
        latest = strptime(loads(latest_json.read().decode("utf-8"))["date"], "%Y-%m-%d %H:%M:%S")

    png = Image.new('RGB', (width*level, height*level))

    counter = Value("i", 0)
    p = Pool(cpu_count() * level)
    res = p.map(download_chunk, product(range(level), range(level), (latest,)))

    for (x, y, tiledata) in res:
        tile = Image.open(BytesIO(tiledata))
        png.paste(tile, (width*x, height*y, width*(x+1), height*(y+1)))

    png.save(output_file, "PNG")


if __name__ == "__main__":
    main()
