SHELL = /usr/bin/bash
.SILENT: link-Xresources

SYSTEM := $(shell sed -n "s/^ID=//p" /etc/os-release)

setup:
ifeq ($(SYSTEM), manjaro)
	sudo pacman -R manjaro-i3-settings
endif
	sudo make enableBluetooth installPackets gitConfig installOhMyZsh \
		installTheHaskellToolStack link-all setupNeoVim ldconfig
	i3exit lock
# link-Xresources mast be last, becouse it may ask confirmation
	make link-Xresources

enableBluetooth:
	systemctl enable bluetooth

fixTime:
	sudo ntpd -qg
	systemctl enable ntpd

LN_ARGS ?= -sT
LN = ln ${LN_ARGS} $$curDir
.ONESHELL:
link-all:
	curDir=$$(pwd)
	test -d ~/.config    || mkdir    ~/.config
	test -d ~/.local/bin || mkdir -p ~/.local/bin
	${LN}/nvim                       ~/.config/nvim
	${LN}/zshrc                      ~/.zshrc
	${LN}/i3                         ~/.config/i3
	${LN}/i3status                   ~/.config/i3status
	${LN}/keynavrc                   ~/.keynavrc
	${LN}/fehbg                      ~/.fehbg
	${LN}/qutebrowser                ~/.config/qutebrowser

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
		ln -sfT $$curDir/Xresources ~/.Xresources
	fi

installOhMyZsh:
	sh -c "`curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh` --unattended"
	mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
	chsh -s `which zsh`

installTheHaskellToolStack:
	curl -sSL https://get.haskellstack.org/ | sh
	cd ~
	stack setup

.ONESHELL:
installPackets:
ifeq ($(SYSTEM), manjaro)
	pacman -Syu --noconfirm
	pacman -S --noconfirm \
		curl git cmake make gnome-terminal qutebrowser python3 bluez bluez-utils \
		gcc qt5-base qtcreator neovim rofi htop ranger pcmanfm zathura shake \
		keynav qalculate-gtk i3-gaps i3lock i3exit i3status zsh zathura-pdf-mupdf \
		clisp libreoffice-fresh libreoffice-fresh-ru ghc-libs ghc-static pandoc \
		nodejs npm php rlwrap clojure cargo
else
	echo "can't install packets on this system ($(SYSTEM))"
endif

ldconfig:
	sudo ldconfig

setupNeoVim:
	nvim -c ":PlugInstall | :qa"
	pip3 install pynvim unicode flake8 yapf
	stack install stylish-haskell hdevtools hsimport hlint

gitConfig:
	git config --global user.name fimmind
	git config --global user.email "fimmind@mail.ru"
	git config --global core.editor nvim

.ONESHELL:
installTexLive:
	test -f texlive.tar.gz || \
		wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -O texlive.tar.gz
	tar -xf texlive.tar.gz
	cd `ls | grep install-tl-*` && ./install-tl -profile ../texlive.profile
