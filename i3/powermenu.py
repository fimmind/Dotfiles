#!/usr/bin/python3
from os import popen

commands = {
    "lock": "i3exit lock",
    "logout": "i3exit logout",
    "suspend": "systemctl suspend",
    "hibernate": "systemctl hibernate",
    "reboot": "systemctl reboot",
    "shutdown": "systemctl shutdown"
}

rofi = "".join([
    "echo '", "\n".join(commands.keys()), "' | rofi -lines ",
    str(len(commands)), " -dmenu -p power"
])

popen(commands[popen(rofi).read()[:-1]])