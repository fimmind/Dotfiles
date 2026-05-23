#!/usr/bin/env fish

function xdg_fzf
  set fname (fzf)
  if [ -n "$fname" ]
    nohup xdg-open "$fname" &> /dev/null &
    disown
  end
end
