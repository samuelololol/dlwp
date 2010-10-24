#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#
#
#
#
import os
import urllib
import HTMLParser

const_source_url = 'http://phantom002.sakura.ne.jp/bbs2/index.html'

# A parser parse the image link from TypeMoon website
#class TypeMoonParser(HTMLParser.HTMLParser):
    
def test(url):
    retval = urllib.urlopen(url)
    while 1:
        line = retval.readline()
        if line:
            print line
        else:
            break
    return retval



source_cont = test(const_source_url)
print source_cont
