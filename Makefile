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
	ln -s $$1 $$curDir/i3                      ~/.config/
	ln -s $$1 $$curDir/i3status                ~/.config/
	ln -s $$1 $$curDir/.vim                    ~/
	ln -s $$1 $$curDir/.zshrc                  ~/
	ln -s $$1 $$curDir/.keynavrc               ~/
	ln -s $$1 $$curDir/deezer/deezer.desktop   ~/.local/share/applications/
	ln -s $$1 $$curDir/deezer/deezer           ~/.local/bin/
	ln -s $$1 $$curDir/.fehbg                  ~/

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
		ln -sf $$1 $$curDir/.Xresources ~/
	fi

installOhMyZsh:
	sh -c "`curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh`"

installHaskellPlatform:
	curl https://get-ghcup.haskell.org -sSf | sh

installTheHaskellToolStack:
	curl -sSL https://get.haskellstack.org/ | sh
