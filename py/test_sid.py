#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
import os
from dl_kon import kon_re_func
from dl_ty  import ty_re_func
from dl_geo import geo_re_func
from dl_img import download_img
from subprocess import call

ty_img = []
kon_img = []
geo_img = []

def main():
    kon_re_func(kon_img) 
    print kon_img

    #ty_re_func(ty_img) 
    #print ty_img

    #geo_re_func(geo_img)
    #print geo_img[0]

    #under linux, but it should be done by another script base on OS instead of python-script
    #call(['ln', '-sf', '/home/samuel/test/test_git/dlwp/py/'+geo_img[0], '/home/samuel/test/test_git/dlwp/py/wallpaper'])




if __name__ == '__main__':
    main()
