SHELL = /usr/bin/bash
.SILENT: link-Xresources setup

SYSTEM := $(shell sed -n "s/^ID=//p" /etc/os-release)

setup:
ifeq ($(SYSTEM), manjaro)
	sudo pacman -R manjaro-i3-settings i3status-manjaro
endif
	$(MAKE) LN_ARGS=-sfT \
		installPackets installBrew enableBluetooth gitConfig installOhMyZsh \
		installTheHaskellToolStack link-all setupNeoVim ldconfig \
		installLeiningen installHIE installBoot-clj
	i3exit lock
	$(MAKE) link-Xresources # Mast be last, because it asks confirmation

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
	${LN}/kitty                      ~/.config/kitty
	${LN}/keynavrc                   ~/.keynavrc
	${LN}/fehbg                      ~/.fehbg
	${LN}/qutebrowser                ~/.config/qutebrowser
	${LN}/profiles.clj               ~/.lein/profiles.clj
	${LN}/brittany                   ~/.config/brittany
	${LN}/broot                      ~/.config/broot
	${LN}/profile                    ~/.profile
	${LN}/conjure                    ~/.config/conjure
	${LN}/tmux.conf                  ~/.tmux.conf

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
	stack install shake

installPackets:
ifeq ($(SYSTEM), manjaro)
	pamac build virtualbox-ext-oracle --no-confirm
	sudo pacman-key --refresh-keys
	sudo pacman -Syu --noconfirm
	sudo pacman -S --noconfirm \
		curl git cmake make kitty qutebrowser python3 bluez bluez-utils \
		gcc neovim rofi htop ranger pcmanfm zathura telegram-desktop lm_sensors jq \
		keynav qalculate-gtk i3-gaps i3lock i3exit i3status zsh zathura-pdf-mupdf \
		clisp libreoffice-fresh libreoffice-fresh-ru ghc-libs ghc-static rustup \
		nodejs npm php rlwrap clojure cargo rogue nethack scala inkscape ruby \
		imagemagick wine winetricks unrar firefox dotnet-sdk ttf-dejavu broot \
		neofetch irssi bind-tools tmux cmatrix \
		virtualbox virtualbox-host-dkms
	rustup default stable
	broot --install
	gem install irb
else
	echo "can't install packets on this system ($(SYSTEM))"
endif

ldconfig:
	ldconfig

setupNeoVim:
	nvim -u "nvim/plugins.vim" -c ":PlugInstall | :qa"
	nvim -c ":call InstallCocExtensions() | :q"
	sudo pip3 install pynvim unicode flake8 yapf sympy inkscape-figures
	stack install stylish-haskell hdevtools
	sudo npm install -g neovim bash-language-server
	brew install ccls

updateVimPlug:
	curl -fLo ./nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

gitConfig:
	git config --global user.name fimmind
	git config --global user.email "fimmind@mail.ru"
	git config --global core.editor nvim

.ONESHELL:
installTexLive:
	cd sources
	test -f texlive.tar.gz || \
		wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -O texlive.tar.gz
	tar -xf texlive.tar.gz
	cd `ls | grep install-tl-*` && ./install-tl -profile ../../texlive.profile

installLeiningen:
	wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
		-O ~/.local/bin/lein
	chmod ug+x ~/.local/bin/lein
	lein

ONESHELL:
installHIE:
	cd sources
	git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules
	cd haskell-ide-engine
	stack ./install.hs hie-8.6.5

ONESHELL:
installFloskell:
	cd sources
	git clone https://github.com/ennocramer/floskell
	cd floskell
	stack install

installBrew:
	echo | sh -c \
		"$$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

installClojure-lsp:
	wget https://github.com/snoe/clojure-lsp/releases/latest/download/clojure-lsp -O ~/.local/bin/clojure-lsp
	chmod 755 ~/.local/bin/clojure-lsp

installClj-kondo:
	pamac build clj-kondo-bin --no-confirm

installBoot-clj:
	brew install boot-clj
	cd && boot
