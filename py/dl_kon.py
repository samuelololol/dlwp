# -*- coding: utf-8 -*-
import os
import re
from dl_page import get_raw_page

kon_page = []
kon_dict = dict()
kon_source_url = 'http://konachan.com/post/popular_recent?period=1d'
kon_re = re.compile(r"""
         (directlink\ largeimg) 
         (.)+
         (<span\ class)  
         (.)+
         """, re.VERBOSE)

def kon_re_func(img):
    subname_re = re.compile(r"""
             (\W+) 
            """, re.VERBOSE)
    kon_page = get_raw_page(kon_source_url) 
    outiter = kon_re.finditer(kon_page)
    for out in outiter:
        link = out.group()
        print link[0]
        #filename = subname_re.split(link)
        #file = filename[18][2:] + '.' + filename[-1]
        #download_img(link, file)
        #print file, link
        img.append(link)
        kon_dict[link] = file
        #print kon_dict
    return
