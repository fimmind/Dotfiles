SHELL = /usr/bin/bash
.SILENT: link-Xresources

SYSTEM := $(shell uname -o)

setup-manjaro-i3:
	sudo pacman -R manjaro-i3-settings 
# link-Xresources mast be last, becouse it may ask confirmation
	sudo make enableBluetooth link-all installPackets gitConfig installOhMyZsh installTheHaskellToolStack installNeoVimPlugins link-Xresources
	i3exit logout

setup-termux: link-all installPackets gitConfig installOhMyZsh installHugs installNeoVimPlugins

enableBluetooth:
	systemctl enable bluetooth

LN_ARGS ?= -sT
LN = ln ${LN_ARGS} $$curDir
.ONESHELL:
link-all:
	curDir=$$(pwd)
	test -d ~/.config    || mkdir ~/.config
	${LN}/nvim                    ~/.config/nvim
	${LN}/zshrc                   ~/.zshrc
ifneq ($(SYSTEM), Android)
	test -d ~/.local/bin || mkdir ~/.local/bin
	${LN}/i3                      ~/.config/i3
	${LN}/i3status                ~/.config/i3status
	${LN}/keynavrc                ~/.keynavrc
	${LN}/deezer/deezer.desktop   ~/.local/share/applications/deezer.desktop
	${LN}/deezer/deezer           ~/.local/bin/deezer
	${LN}/fehbg                   ~/.fehbg
endif

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
		ln -sf $$curDir/Xresources ~/.Xresources
	fi

installOhMyZsh:
	sh -c "`curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh` --unattended"
	mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
	chsh -s zsh

installTheHaskellToolStack:
	curl -sSL https://get.haskellstack.org/ | sh
	cd ~
	stack setup

.ONESHELL:
installPackets:
ifeq ($(SYSTEM), Android)
	pkg install -y build-essential cmake libclang proot python python-dev curl neovim htop zsh
else
	pacman -S --noconfirm \
		curl git cmake make gnome-terminal chromium python3 bluez bluez-utils \
		gcc qt5-base qtcreator neovim rofi htop ranger pcmanfm zathura shake \
		keynav qalculate-gtk i3-gaps i3lock i3exit i3status zsh zathura-pdf-mupdf \
		texlive-core texlive-bin texlive-core texlive-langcyrillic
endif

installNeoVimPlugins:
	nvim -c ":PlugInstall | :qa"

gitConfig:
	git config --global user.name fimmind
	git config --global user.email "grayfox19@mail.ru"

.ONESHELL:
installHugs:
	termux-chroot "cd ~ \
		&& git clone https://github.com/trenttobler/android-termux-hugs.git \
		&& cd android-termux-hugs \
		&& make install"
