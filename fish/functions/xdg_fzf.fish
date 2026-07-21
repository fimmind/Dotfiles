#!/usr/bin/env fish

function xdg_fzf
  set fname (fzf)
  test -n "$fname"
  or return

  setsid xdg-open "$fname" >/dev/null 2>&1 </dev/null &
end
