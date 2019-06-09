SHELL = /usr/bin/bash
.SILENT: link-Xresources

default:
	sudo make all

all: enableBluetooth link-all installPackets installOhMyZsh installTheHaskellToolStack installHIE installVimPlugins link-Xresources
# link-Xresources mast be last, becouse it may ask confirmation

enableBluetooth:
	systemctl enable bluetooth

LN_ARGS ?= -s
LN = ln ${LN_ARGS} $$curDir
.ONESHELL:
link-all:
	curDir=$$(pwd)
	test -d ~/.config || mkdir ~/.config
	test -d ~/.local/bin || mkdir ~/.local/bin
	${LN}/i3                      ~/.config/
	${LN}/i3status                ~/.config/
	${LN}/.vim                    ~/
	${LN}/.zshrc                  ~/
	${LN}/.keynavrc               ~/
	${LN}/deezer/deezer.desktop   ~/.local/share/applications/
	${LN}/deezer/deezer           ~/.local/bin/
	${LN}/.fehbg                  ~/

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
	sh -c "`curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh` --unattended"

installTheHaskellToolStack:
	curl -sSL https://get.haskellstack.org/ | sh
	stack setup

installHIE:
	git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules
	cd haskell-ide-engine
	stack ./install.hs hie-8.4.4
	stack ./install.hs build-doc
	stack install

installPackets:
	pacman -S --noconfirm \
		curl git cmake make gnome-terminal chromium python3 bluez bluez-utils \
		gcc qt5-base qtcreator vim rofi htop ranger pcmanfm zathura shake keynav \
		qalculate-gtk

installVimPlugins:
	vim -c ":PlugInstall | :qa"
