export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
HIST_STAMPS="dd.mm.yy"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git python pip vim-interaction)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'
setopt +o nomatch

if [[ -n $(bash -c "compgen -c | grep -w eopkg") ]]; then
  autoload bashcompinit
  bashcompinit
  source /usr/share/bash-completion/completions/eopkg
fi

PATH="$PATH:$HOME/.local/bin:$HOME/bin"
