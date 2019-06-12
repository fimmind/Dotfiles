SHELL = /usr/bin/bash
.SILENT: link-Xresources

setup-manjaro:
	sudo pacman -R manjaro-i3-settings 
	sudo make all
	i3exit logout

all: enableBluetooth link-all installPackets installOhMyZsh installTheHaskellToolStack installVimPlugins link-Xresources
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

installPackets:
	pacman -S --noconfirm \
		curl git cmake make gnome-terminal chromium python3 bluez bluez-utils \
		gcc qt5-base qtcreator gvim rofi htop ranger pcmanfm zathura shake keynav \
		qalculate-gtk i3-gaps i3lock i3exit i3status zsh \
		texlive-core texlive-bin texlive-core texlive-langcyrillic

installVimPlugins:
	vim -c ":PlugInstall | :qa"
