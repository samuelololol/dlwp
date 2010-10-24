#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#
#
#
#
import os
import urllib
import re

ty_source_url = 'http://phantom002.sakura.ne.jp/bbs2/index.html'
ty_img_url = 'http://phantom002.sakura.ne.jp/bbs2/'
p1 = re.compile(r"""
        画像タイトル：(.)+.$ 
        """, re.VERBOSE | re.MULTILINE) 

p2 = re.compile(r"""
        src/[\d]+.[\w]+
        """,re.VERBOSE)
ty_img = []


# using read() function to get the page content of Typemoon
def ty_get_raw_page(url,decode,encode):
    data = urllib.urlopen(url).read().decode(decode).encode(encode)
    return data

# do some regular expression test
def ty_test_re1(data):
    out = p1.finditer(data)
    return out

def ty_test_re2(line):
    name = p2.findall(line)
    return name
    #return line

def ty_re(data):
    outiter = p1.finditer(data)
    for out in outiter:
        ty_img.append(ty_img_url+p2.findall(out.group())[0]) 
    return ty_img

source_cont_page = ty_get_raw_page(ty_source_url,'shift-jis','utf-8')

print ty_re(source_cont_page)
