# -*- coding: utf-8 -*-
import os
import re
from dl_page import get_raw_page
from dl_img import download_img

geo_page = []
geo_dict = dict()
geo_source_url = 'http://photography.nationalgeographic.com/photography/photo-of-the-day'
geo_re = re.compile(r"""
         (download_link)        # start of 'similarhr' or 'similarlr'
         (.)+                   
         (</div>\r)  
         """, re.VERBOSE)

def geo_re_func(img):
    subname_re = re.compile(r"""
            [\/]
            """, re.VERBOSE)
    geo_page = get_raw_page(geo_source_url) 
    outiter = geo_re.finditer(geo_page)
    for out in outiter:
        link = out.group()[24:-52]
        filename = subname_re.split(link)
        file = filename[9]
        download_img(link, file)
        #print file, link
        #img.append(link)
        img.append(file)

        #geo_dict[link] = file
        #print geo_dict
    return 
