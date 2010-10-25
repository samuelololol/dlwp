# -*- coding: utf-8 -*-
import os
import urllib

# using read() function to get the page content of Typemoon
def get_raw_page(url, decode = 'utf-8', encode = 'utf-8'):
    raw_page = urllib.urlopen(url).read().decode(decode).encode(encode)
    return raw_page
