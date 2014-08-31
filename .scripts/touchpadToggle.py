#!/usr/bin/python2

import os

def ReadFile():
    myfile = open('/tmp/synclient.tmp', 'rb')
    for line in myfile:
        TestString(line)
    myfile.close()

def TestString(string):
    for word in string.split():
        if word == "TouchpadOff":
            setting = string.split()
            ChangeState(setting[2])

def ChangeState(current):
    if current == "0":
        os.system("synclient touchpadoff=1")
    else:
        os.system("synclient touchpadoff=0")
    os.system("rm /tmp/synclient.tmp")

def Main():
        ReadFile()

os.system("synclient -l > /tmp/synclient.tmp")
Main()
