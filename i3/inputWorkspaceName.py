#!/usr/bin/python3
import json
from os import *

namesList = ""
firstLine = True
for i in json.load(popen('i3-msg -t get_workspaces')):
  if firstLine:
    firstLine = False
  else:
    namesList += '\n'
  namesList += i['name']

system('echo -e "' + namesList + '" | rofi -dmenu -p workspace')
