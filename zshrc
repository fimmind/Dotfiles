export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
HIST_STAMPS="%d.%m.%y %H:%M:%S"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git vim-interaction stack)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
setopt +o nomatch

if [[ -n $(bash -c "compgen -c | grep -w eopkg") ]]; then
  autoload bashcompinit
  bashcompinit
  source /usr/share/bash-completion/completions/eopkg
fi

alias ru="setxkbmap us,ru ,winkeys grp:caps_toggle"
alias fix_time="sudo ntpd -qg"
alias vimrc="nvim -c Vimrc"
alias getamsterdam="cp ~/Dotfiles/beamerthemeAmsterdam.sty ./"

PATH="$PATH:$HOME/.local/bin:$HOME/bin:/usr/local/bin"
PATH="$PATH:/usr/local/texlive/2019/bin/x86_64-linux"

MANPATH="$MANPATH:/usr/local/texlive/2019/texmf-dist/doc/man"
INFOPATH="$INFOPATH:/usr/local/texlive/2019/texmf-dist/doc/info"

if [ "`uname -o`" == "Android" ]; then
  alias chroot="termux-chroot && exit"
  alias hugs="termux-chroot hugs"
  alias runhugs="termux-chroot runhugs"
fi
