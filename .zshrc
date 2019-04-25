export ZSH="/home/fimmind/.oh-my-zsh"

ZSH_THEME="robbyrussell"
HIST_STAMPS="dd.mm.yy"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git python pip vim-interaction)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'
setopt +o nomatch

autoload bashcompinit
bashcompinit
source /usr/share/bash-completion/completions/eopkg


alias calc=gnome-calculator
