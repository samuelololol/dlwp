# -*- coding: utf-8 -*-
import os
import re
from dl_page import get_raw_page

kon_page = []
kon_source_url = 'http://konachan.com/post/popular_recent?period=1d'
kon_re = re.compile(r"""
         (similarhr|similarlr)  # start of 'similarhr' or 'similarlr'
         (.)+                   # else
         (<span>)               # trailing span
         """, re.VERBOSE)

def kon_re_func(img):
    kon_page = get_raw_page(kon_source_url) 
    outiter = kon_re.finditer(kon_page)
    for out in outiter:
        img.append(out.group()[17:-8]) 
    return
