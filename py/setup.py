# the setup.py for py2exe under windows

from distutils.core import setup
import py2exe
setup(
        windows = ['test_sid.py'],
        options = {'py2exe': {'bundle_files': 1 }},
        zipfile = None
     ) 

