SHELL = /usr/bin/bash
.SILENT: link-Xresources

default: link-all

all: link-all link-Xresources installOhMyZsh installHaskellPlatform

.ONESHELL:
link-all: link-Xresources
	curDir=$$(pwd)
	if [ ! -d ~/.config ]; then
		mkdir ~/.config
	fi
	ln -s $$curDir/i3                      ~/.config/
	ln -s $$curDir/i3status                ~/.config/
	ln -s $$curDir/.vim                    ~/
	ln -s $$curDir/.zshrc                  ~/
	ln -s $$curDir/.keynavrc               ~/
	ln -s $$curDir/deezer/deezer.desktop   ~/.local/share/applications/
	ln -s $$curDir/deezer/deezer           ~/.local/bin/
	ln -s $$curDir/.fehbg                  ~/

.ONESHELL:
link-Xresources:
	curDir=$$(pwd)
	if [ -f ~/.Xresources ] && [ ! -L ~/.Xresources ]; then
		echo ".Xresources file already exists. Would you like to replace it? (y/n)"
		read answer
	else
		answer=y
	fi
	if [ "$$answer" = "y" ]; then
		ln -sf $$curDir/.Xresources ~/
	fi

installOhMyZsh:
	sh -c "`curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh`"

installTheHaskellToolStack:
	curl -sSL https://get.haskellstack.org/ | sh
