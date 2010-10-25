#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
#
#
#
#
import os
from dl_kon import kon_re_func
from dl_ty  import ty_re_func
from dl_img import download_img

ty_img = []
kon_img = []

def main():
    kon_re_func(kon_img) 
    print kon_img

    ty_re_func(ty_img) 
    print ty_img


if __name__ == '__main__':
    main()
