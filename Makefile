SHELL = /usr/bin/bash
.SILENT: link-Xresources

SYSTEM := $(shell sed -n "s/^ID=//p" /etc/os-release)

setup:
ifeq ($(SYSTEM), manjaro)
	sudo pacman -R manjaro-i3-settings
endif
	sudo make enableBluetooth installPackets gitConfig installOhMyZsh \
		installBrew installTheHaskellToolStack link-all setupNeoVim ldconfig \
		installLeiningen installClj-kondo installHIE
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
	test -d ~/.lein      || mkdir    ~/.lein
	${LN}/nvim                       ~/.config/nvim
	${LN}/zshrc                      ~/.zshrc
	${LN}/i3                         ~/.config/i3
	${LN}/i3status                   ~/.config/i3status
	${LN}/keynavrc                   ~/.keynavrc
	${LN}/fehbg                      ~/.fehbg
	${LN}/qutebrowser                ~/.config/qutebrowser
	${LN}/profiles.clj               ~/.lein/profiles.clj

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
		gcc neovim rofi htop ranger pcmanfm zathura shake telegram-desktop \
		keynav qalculate-gtk i3-gaps i3lock i3exit i3status zsh zathura-pdf-mupdf \
		clisp libreoffice-fresh libreoffice-fresh-ru ghc-libs ghc-static pandoc \
		nodejs npm php rlwrap clojure cargo rogue nethack scala inkscape ruby \
else
	echo "can't install packets on this system ($(SYSTEM))"
endif

ldconfig:
	ldconfig

setupNeoVim:
	nvim -c ":PlugInstall | :qa"
	nvim -c ":call InstallCocExtentions() | :q"
	pip3 install pynvim unicode flake8 yapf sympy inkscape-figures
	stack install stylish-haskell
	npm install -g neovim
	brew install ccls

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

installLeiningen:
	wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
		-O ~/.local/bin/lein
	chmod ug+x ~/.local/bin/lein
	lein

installClj-kondo:
	bash <(curl -s https://raw.githubusercontent.com/borkdude/clj-kondo/master/script/install-clj-kondo) \
		--dir ~/.local/bin
	clj-kondo

ONESHELL:
installHIE:
	git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules
	cd haskell-ide-engine
	stack ./install.hs build

installBrew:
	gem install irb
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
