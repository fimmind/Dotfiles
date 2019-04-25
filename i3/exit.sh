#!/bin/sh
test $(echo -e "Yes\nNo" | dmenu -i -p "Are you shure you want to exit?") = "Yes" && \
  i3-msg exit

