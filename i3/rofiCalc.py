#!/usr/bin/python3
from os import popen

rofiCmd = "rofi -dmenu -p calc -no-show-match -lines 0"
history = ""

equation = popen(rofiCmd).read()
while equation and equation != "\n" and equation != "exit\n":
    history = popen(f"qalc '{equation}'").read() + history
    equation = popen(f"{rofiCmd} -mesg '{history[0:-1]}'").read()
