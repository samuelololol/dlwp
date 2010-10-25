# -*- coding: utf-8 -*-
import os
import re
from dl_page import get_raw_page
from dl_img  import download_img

ty_page = []
ty_source_url = 'http://phantom002.sakura.ne.jp/bbs2/index.html'
ty_re = re.compile(r"""
        画像タイトル：          # start of '画像タイトル：'
        (
         .........              # 9 digits
         src/                   # sub-key string
         [\d]+                  # img filename
         .                      # dot
         [\w]+                  # sub filename
        )
        """, re.VERBOSE)


# the filter of ty image by regex
def ty_re_func(img):
    ty_img_url = 'http://phantom002.sakura.ne.jp/bbs2/'

    ty_page = get_raw_page(ty_source_url, 'shift-jis') 
    outiter = ty_re.finditer(ty_page)
    for out in outiter:
        name = out.group()[34:]
        link = ty_img_url + out.group()[30:]
        img.append(link)
        #download_img(link, name)
        print link, name
    return

