#!/bin/python2
#
# Usage:  for l in $(pdfLister.py <url>); do wget $l; done
#

from urllib import urlopen
from bs4 import BeautifulSoup as BSoup

import sys
import os

def usage(argv):
    cmd = os.path.basename(argv[0])
    print('=> Usage: %s <url>' % (cmd))
    sys.exit(1)

def removeUrlParts(url):
    url = url.split('/')
    url.pop(0)
    url.pop(0)
    url.pop(-1)
    return url

def main(argv):
    if len(argv) != 2:
        usage(argv)
    url = removeUrlParts(argv[1])

    soup = BSoup(urlopen(argv[1]), 'lxml')
    for a in soup.findAll('a'):
        if a.attrs.get('href') and 'pdf' in a.attrs.get('href'):
            print('%s/%s' % 
                    ('/'.join(url), a.attrs.get('href')))


if __name__ == "__main__":
    main(sys.argv)
