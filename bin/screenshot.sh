#!/usr/bin/bash

case $1 in
  full)
    scrot -m ~/Pictures/`date +'%d.%m.%y_%T:%N'`.png;;
  window)
    scrot -s ~/Pictures/`date +'%d.%m.%y_%T:%N'`.png;;
  *) ;;
esac
