export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
HIST_STAMPS="%d.%m.%y %H:%M:%S"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git vim-interaction stack)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export PAGER='less'
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
PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

MANPATH="$MANPATH:/usr/local/texlive/2019/texmf-dist/doc/man"
INFOPATH="$INFOPATH:/usr/local/texlive/2019/texmf-dist/doc/info"

if [ "`uname -o`" == "Android" ]; then
  alias chroot="termux-chroot && exit"
  alias hugs="termux-chroot hugs"
  alias runhugs="termux-chroot runhugs"
fi


export WINEPREFIX=$HOME/.wine
export WINEARCH=win32


# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] 2>/dev/null ))
}
compctl -K _pip_completion pip
# pip zsh completion end

source /home/fimmind/.config/broot/launcher/bash/br
