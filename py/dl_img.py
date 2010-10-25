# -*- coding: utf-8 -*-
import os
import urllib

def download_img(url, name):
    img = urllib.URLopener() 
    img.retrieve(url, name)
    return
