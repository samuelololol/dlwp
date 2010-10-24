#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#
#
#
#
import os
import urllib
import lxml

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

# using read() function to get the page content of Typemoon
def ty_get_raw_page(url):
    data = urllib.urlopen(url).read().decode('shift-jis').encode('utf-8')
    return data

# do some regular expression test
def ty_test_re(data):
    return data
    
# using xpath

source_cont = ty_get_raw_page(const_source_url)
source_cont_after_re = ty_test_re(source_cont)

print source_cont_after_re
