# -*- coding: utf-8 -*-
#!/usr/bin/python

def fetchURL(vid):
    return "http://nrk.no/serum/api/video/%s" % vid

def tumbleURL(url, bitrate):
    url = url.replace('/z/', '/i/', 1)
    url = url.rsplit('/', 1)[0]
    url = url + '/index_%s_av.m3u8' % bitrate
    return url
