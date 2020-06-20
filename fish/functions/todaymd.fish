#!/usr/bin/env fish

function todaymd
  set file (date '+%Y_%m_%d.md')
  if test ! -e $file
    date '+# %Y.%m.%d %A' > $file
  end
  nvim $file
end
