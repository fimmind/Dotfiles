#!/usr/bin/python3
from os import *

name = popen('./inputWorkspaceName.py').read()
system('i3-msg move container to workspace "' + name + '"')
system('i3-msg workspace "' + name + '"')
