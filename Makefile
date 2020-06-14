SHELL = /usr/bin/bash
.SILENT: link-Xresources setup

SYSTEM := $(shell sed -n "s/^ID=//p" /etc/os-release)

setup:
	sudoers=/etc/sudoers.d/$$USER
	if sudo [ -e $$sudoers ]; then
		echo "File '$$sudoers' exists, but this script will override it."
		read -p "Continue? (y/n) " -n 1 answer
		echo
		if [ $$answer != y ]; then
			exit 0
		fi
	fi
	echo "$$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee $$sudoers
	$(MAKE) LN_ARGS=-sfT \
		link-all installPackets installBrew installBrewPackets enableBluetooth \
		installTheHaskellToolStack setupNeoVim ldconfig \
		setup-default-apps installLeiningen installHIE installOhMyFish
	sudo rm $$sudoers

enableBluetooth:
	sudo systemctl enable bluetooth

fixTime:
	sudo ntpd -qg
	sudo systemctl enable ntpd

LN_ARGS ?= -sT
LN = ln ${LN_ARGS} $$curDir
.ONESHELL:
link-all:
	curDir=$$(pwd)
	test -d ~/.config    || mkdir    ~/.config
	test -d ~/.local/bin || mkdir -p ~/.local/bin
	test -d ~/.lein      || mkdir    ~/.lein
	${LN}/gitconfig                  ~/.gitconfig
	${LN}/nvim                       ~/.config/nvim
	${LN}/fish                       ~/.config/fish
	${LN}/omf                        ~/.config/omf
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
	${LN}/tmux.conf                  ~/.tmux.conf
	${LN}/cljstyle                   ~/.cljstyle
	${LN}/rofi                       ~/.config/rofi
	${LN}/Xresources                 ~/.Xresources

installOhMyZsh:
	sh -c "`curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh` --unattended"
	mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc

ONESHELL:
installOhMyFish:
	cd sources
	curl -L https://get.oh-my.fish > get-omf.fish
	fish get-omf.fish --noninteractive
	fish -c "omf install sashimi"

installTheHaskellToolStack:
	curl -sSL https://get.haskellstack.org/ | sh
	cd ~
	stack setup
	stack install shake

installPackets:
ifeq ($(SYSTEM), manjaro)
	pamac build virtualbox-ext-oracle --no-confirm
	pamac install discord --no-confirm
	sudo pacman -R manjaro-i3-settings i3status-manjaro --noconfirm
	sudo pacman -S --noconfirm \
		curl git cmake make kitty qutebrowser python3 bluez bluez-utils pandoc \
		gcc neovim rofi htop ranger pcmanfm zathura telegram-desktop lm_sensors jq \
		keynav qalculate-gtk i3-gaps i3lock i3exit i3status fish zathura-pdf-mupdf \
		clisp libreoffice-fresh libreoffice-fresh-ru ghc-libs ghc-static rustup \
		nodejs npm php rlwrap clojure cargo rogue nethack scala inkscape ruby \
		imagemagick wine winetricks unrar firefox dotnet-sdk ttf-dejavu broot \
		neofetch irssi bind-tools tmux cmatrix cmus figlet deluge deluge-gtk \
		virtualbox virtualbox-host-dkms go gnome-mplayer gnome-screenshot gnugo \
		playerctl muparser opera chromium zathura-djvu feh python-pip ctags
	sudo npm install -g add-gitignore
	pip install pylatexenc
	rustup default stable
	broot --install
	gem install irb
else
	echo "can't install packets on this system ($(SYSTEM))"
endif

setup-default-apps:
	xdg-mime default org.pwmt.zathura.desktop application/pdf
	xdg-mime default org.qutebrowser.qutebrowser.desktop x-scheme-handler/http
	xdg-mime default org.qutebrowser.qutebrowser.desktop x-scheme-handler/https
	xdg-mime default org.qutebrowser.qutebrowser.desktop text/html
	xdg-mime default kitty.desktop application/x-shellscript
	xdg-mime default kitty.desktop application/x-sharedlib
	xdg-mime default nvim.desktop text/markdown

ldconfig:
	sudo ldconfig

setupNeoVim: updateVimPlug
	nvim -u "nvim/plugins.vim" -c ":PlugInstall | :qa"
	nvim -c ":call InstallCocExtensions() | :qa"
	sudo pip3 install pynvim unicode flake8 yapf sympy inkscape-figures
	stack install stylish-haskell hdevtools
	sudo npm install -g neovim bash-language-server browser-sync
	gem install neovim

updateVimPlug:
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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

remove = \
				if [ -e $(1) ]; then \
					echo; \
					printf "File $(1) exists. Do you want do delete it? (y/n) "; \
					read answer; \
					echo; \
					if [ "$$answer" = "y" ]; then \
						rm $(1) -rf; \
					fi \
				fi

ONESHELL:
installHIE:
	cd sources
	$(call remove,./haskell-ide-engine)
	git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules
	cd haskell-ide-engine
	stack ./install.hs latest

ONESHELL:
installFloskell:
	cd sources
	$(call remove,./floskell)
	git clone https://github.com/ennocramer/floskell
	cd floskell
	stack install

ONESHELL:
installZoom:
	cd sources
	$(call remove,./zoom_x86_64.pkg.tar.xz)
	wget https://zoom.us/client/latest/zoom_x86_64.pkg.tar.xz \
		&& sudo pacman -U zoom_x86_64.pkg.tar.xz --noconfirm

installBrew:
	echo | sh -c \
		"$$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

installBrewPackets:
	/home/linuxbrew/.linuxbrew/bin/brew install \
		candid82/brew/joker ccls

installClojure-lsp:
	wget https://github.com/snoe/clojure-lsp/releases/latest/download/clojure-lsp -O ~/.local/bin/clojure-lsp
	chmod 755 ~/.local/bin/clojure-lsp

installClj-kondo:
	pamac build clj-kondo-bin --no-confirm

installBoot-clj:
	brew install boot-clj
	cd && boot

ONESHELL:
installJ:
	cd sources
	$(call remove,./j8-git)
	git clone https://aur.archlinux.org/j8-git.git
	cd j8-git
	makepkg -s --noconfirm
	makepkg -i --noconfirm
