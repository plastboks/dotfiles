# -*- coding: utf-8 -*-
#!/usr/bin/python

from urllib import urlopen
from bs4 import BeautifulSoup as BSoup

import sys
import os
import json
import subprocess



def getVideoID(url):
    url = url.split('/')  
    return url[5]
    
def getFeedData(vid):
    url = "http://nrk.no/serum/api/video/%s" % vid
    soup = BSoup(urlopen(url))
    return json.loads(soup.p.string)['mediaURL']

def makeFileName(url):
    url = url.split('/')
    string = "%s-s%02de%02d.mpg" % (url[4],
                                int(url[6].split('-')[1]),
                                int(url[7].split('-')[1]))
    return string

def tumbleURL(url, bitrate):
    url = url.replace('/z/', '/i/', 1)
    url = url.rsplit('/', 1)[0]
    url = url + '/index_%s_av.m3u8' % bitrate
    return url

def usage(argv):
    cmd = os.path.basename(argv[0])
    print('usage: %s <url>\n'
          '(example: "%s http://tv.nrk.no/")' % (cmd, cmd))
    sys.exit(1)

def main(argv):
    if len(argv) != 2:
        usage(argv)
    vID = getVideoID(argv[1])
    feedURL = tumbleURL(getFeedData(vID), 3)
    fileName = makeFileName(argv[1])
    process = subprocess.Popen("vlc %s --sout=file/ts:%s" % (feedURL, fileName),
                               shell=True,
                               stdout=subprocess.PIPE)
    process.wait()
    print process.returncode

if __name__ == "__main__":
    main(sys.argv)
