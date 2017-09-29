#!/usr/bin/env python3
# PYTHON_ARGCOMPLETE_OK
import __future__
import argcomplete
import argparse
import os
import sys
import logging
import hashlib
import glob
import tempfile
import zipfile
import shutil
import platform
import json

import appdirs
try:
    from .github_repos import Github_Repos
    from . import flash_dfu
    from . import flash_serial
except Exception:
    from github_repos import Github_Repos
    import flash_dfu
    import flash_serial

try:
    from urllib import urlretrieve
except ImportError:  # Python 3
    from urllib.request import urlretrieve

__version__ = '0.2.2-dev'
SKELETON_URL_ZIP = 'https://github.com/bigclownlabs/bcf-skeleton-core-module/archive/master.zip'
SDK_URL_ZIP = 'https://github.com/bigclownlabs/bcf-sdk-core-module/archive/master.zip'
SDK_GIT = 'https://github.com/bigclownlabs/bcf-sdk-core-module.git'

# -- bottle --
from bottle import route, run, response

@route('/devices')
def devices():
    response.set_header('Access-Control-Allow-Origin', '*')
    devices = flash_dfu.get_list_devices() + flash_serial.get_list_devices()
    return json.dumps(devices)

@route('/static/<filename:path>')
def send_static(filename):
    return static_file(filename, root='files')

run(host='localhost', port=8080, debug=True)
