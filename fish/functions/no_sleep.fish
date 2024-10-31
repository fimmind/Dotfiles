#!/usr/bin/env fish

function no_sleep
  xdotool mousemove_relative 1 1
  sleep 299
  xdotool mousemove_relative -- -1 -1
  sleep 299
end
