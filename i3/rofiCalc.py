#!/usr/bin/python3
from os import popen

history = ""
equation = popen("rofi -dmenu -p calc -no-show-match -lines 0").read()
while equation and equation != "exit":
  history = popen("qalc '" + equation +"'").read() + history
  equation = \
    popen( \
      # Delete last char, cause it's '\n'
      f"rofi \
      -dmenu \
      -p calc \
      -no-show-match \
      -lines 0 \
      -mesg '{history[0:-1]}'" \
    ).read()
