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
		link-all installPackets installOhMyFish installBrew installBrewPackets \
		enableBluetooth enableNetworkManager enablePulseaudio enableCUPS \
		installDoom installPolybar setupNeoVim ldconfig setup-default-apps \
		installTheme-components setupVirtualBox installLeiningen installHIE
	sudo rm $$sudoers

enableBluetooth:
	sudo systemctl enable bluetooth
	sudo systemctl start bluetooth

enableNetworkManager:
	sudo systemctl enable NetworkManager
	sudo systemctl start NetworkManager

enablePulseaudio:
	systemctl --user enable pulseaudio.service
	systemctl --user start pulseaudio.service

enableCUPS:
	sudo systemctl enable org.cups.cupsd.service
	sudo systemctl start org.cups.cupsd.service

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
	${LN}/xinitrc                    ~/.xinitrc
	${LN}/gitconfig                  ~/.gitconfig
	${LN}/nvim                       ~/.config/nvim
	${LN}/fish                       ~/.config/fish
	${LN}/omf                        ~/.config/omf
	${LN}/bspwm                      ~/.config/bspwm
	${LN}/sxhkd                      ~/.config/sxhkd
	${LN}/polybar                    ~/.config/polybar
	${LN}/kitty                      ~/.config/kitty
	${LN}/keynavrc                   ~/.keynavrc
	${LN}/qutebrowser                ~/.config/qutebrowser
	${LN}/profiles.clj               ~/.lein/profiles.clj
	${LN}/brittany                   ~/.config/brittany
	${LN}/broot                      ~/.config/broot
	${LN}/tmux.conf                  ~/.tmux.conf
	${LN}/cljstyle                   ~/.cljstyle
	${LN}/rofi                       ~/.config/rofi
	${LN}/Xresources                 ~/.Xresources
	${LN}/rustfmt.toml               ~/.rustfmt.toml

installOhMyZsh:
	sh -c "`curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh` --unattended"
	mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc

ONESHELL:
installOhMyFish:
	cd sources
	curl -L https://get.oh-my.fish > get-omf.fish
	fish get-omf.fish --noninteractive
	fish -c "omf install sashimi"

installPackets:
ifeq ($(SYSTEM), arch)
	sudo pacman -S --noconfirm \
		wget curl git cmake make kitty qutebrowser python3 bluez bluez-utils pandoc \
		ccls gcc neovim rofi htop ranger pcmanfm zathura flatpak lm_sensors jq \
		keynav qalculate-gtk bspwm sxhkd xorg-xsetroot fish zathura-pdf-mupdf \
		clisp libreoffice-fresh libreoffice-fresh-ru ghc-libs ghc-static rustup \
		nodejs npm php rlwrap clojure cargo rogue nethack scala inkscape ruby \
		imagemagick unrar firefox dotnet-sdk ttf-dejavu broot xclip alsa-utils \
		neofetch irssi bind-tools tmux cmatrix cmus figlet deluge deluge-gtk \
		playerctl muparser opera chromium zathura-djvu feh python-pip ctags \
		zenity wireless_tools telegram-desktop adobe-source-code-pro-fonts \
		networkmanager base-devel mlocate tree stack cups cups-pdf xsecurelock \
		go gnome-mplayer maim gnugo unclutter gimp emacs ripgrep gcolor2 \
		pulseaudio pulseaudio-bluetooth pulseaudio-alsa \
		virtualbox virtualbox-host-modules-arch virtualbox-guest-iso
	sudo npm install -g add-gitignore
	pip install pylatexenc hy
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

setupNeoVim:
	nvim -u "nvim/plugins.vim" -c ":qa"
	nvim -c ":call InstallCocExtensions() | :qa"
	sudo pip3 install pynvim unicode jedi flake8 yapf sympy inkscape-figures
	stack install stylish-haskell hdevtools
	sudo npm install -g neovim bash-language-server browser-sync
	gem install neovim

.ONESHELL:
installTexLive:
	cd sources
	test -f texlive.tar.gz || \
		wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -O texlive.tar.gz
	tar -xf texlive.tar.gz
	cd `ls | grep install-tl-*` && sudo ./install-tl -profile ../../texlive.profile

installLeiningen:
	wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
		-O ~/.local/bin/lein
	chmod ug+x ~/.local/bin/lein
	~/.local/bin/lein

remove = \
	if [ -e $(1) ]; then \
		echo; \
		printf "File $(1) exists. Do you want do delete it? [y/N] "; \
		read answer; \
		echo; \
		if [ "$$answer" = "y" -o "$$answer" = "Y" ]; then \
			rm $(1) -rf; \
		fi \
	fi

aur_build = \
	cd sources; \
	if [ -e $(1) ]; then \
		if [ -d $(1) ]; then \
			cd $(1); \
			git pull; \
		else \
			echo "ERROR: file `sources/$(1)` exists but is not a directory"; \
			exit 1; \
		fi; \
	else \
		git clone aur:$(1); \
		cd $(1); \
	fi; \
	makepkg -si --noconfirm;

ONESHELL:
installHIE:
	$(call aur_build,haskell-ide-engine)

ONESHELL:
installFloskell:
	cd sources
	$(call remove,floskell)
	git clone https://github.com/ennocramer/floskell
	cd floskell
	stack install

installZoom:
	flatpak install -y \
		https://flathub.org/repo/appstream/us.zoom.Zoom.flatpakref

installBrew:
	echo | sh -c \
		"$$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

installBrewPackets:
	/home/linuxbrew/.linuxbrew/bin/brew install \
		candid82/brew/joker

installClojure-lsp:
	wget https://github.com/snoe/clojure-lsp/releases/latest/download/clojure-lsp \
		-O ~/.local/bin/clojure-lsp
	chmod 755 ~/.local/bin/clojure-lsp

installClj-kondo:
	$(call aur_build,clj-kondo-bin)

installBoot-clj:
	brew install boot-clj
	cd && boot

ONESHELL:
installJ:
	cd sources
	$(call remove,j8-git)
	git clone https://aur.archlinux.org/j8-git.git
	cd j8-git
	makepkg -s --noconfirm
	makepkg -i --noconfirm

ONESHELL:
installSpotify:
	curl -sS https://download.spotify.com/debian/pubkey.gpg | gpg --import -
	$(call aur_build,spotify)

installTheme-components:
	sudo pacman -S papirus-icon-theme
	$(call aur_build,plata-theme)
	$(call aur_build,breeze-default-cursor-theme)

installRocketChat:
	$(call aur_build,rocketchat-client-bin)

installPolybar:
	$(call aur_build,polybar)

setupVirtualBox:
	$(call aur_build,virtualbox-ext-oracle)
	sudo gpasswd -a $$USER vboxusers

installCgoban:
	$(call aur_build,cgoban3)

installDoom:
	git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
	~/.emacs.d/bin/doom -y install
	rustup component add rust-src
	curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux \
		-o ~/.local/bin/rust-analyzer
	chmod +x ~/.local/bin/rust-analyzer
	pip install pipenv black isort
