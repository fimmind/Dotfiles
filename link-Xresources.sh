#/usr/bin/bash
curDir=$(pwd)

if [ -f ~/.Xresources ] && [ ! -L ~/.Xresources ]; then
  echo ".Xresources file already exists. Would you like to replace it? (y/n)"
  read answer
else
  answer=y
fi

if [ "$answer" = "y" ]; then
  ln -sf $1 $curDir/.Xresources ~/
fi
