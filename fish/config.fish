alias ru="setxkbmap us,ru ,winkeys grp:caps_toggle"
alias fix_time="sudo ntpd -qg"
alias vimrc="nvim -c Vimrc"
alias getamsterdam="cp ~/Dotfiles/beamerthemeAmsterdam.sty ./"
alias weather="curl wttr.in/moscow"
alias test-unicode="curl https://www.cl.cam.ac.uk/~mgk25/ucs/examples/UTF-8-demo.txt | less"

alias la="ls -AlF"
alias l="ls -CF"
alias ll="ls -ACF"
alias gs="git status"
alias gd="git diff"
alias gi="add-gitignore"

alias dmenu="dmenu -nb '#18191d' -nf '#bbbbbb' -sb '#005577' -sf '#eeeeee' -fn 'DejaVu Sans Mono:size=10'"

set MANPATH  "$MANPATH:/usr/local/texlive/2019/texmf-dist/doc/man"
set INFOPATH "$INFOPATH:/usr/local/texlive/2019/texmf-dist/doc/info"

if [ "`uname -o`" = "Android" ]
  alias chroot="termux-chroot && exit"
  alias hugs="termux-chroot hugs"
  alias runhugs="termux-chroot runhugs"
end

set fish_greeting

function fish_user_key_bindings
    fish_default_key_bindings
end

# ENVIRONMENT
set -x QT_QPA_PLATFORMTHEME "qt5ct"
set -x EDITOR "/usr/bin/nvim"
set -x GTK2_RC_FILES "$HOME/.gtkrc-2.0"
set -x BROWSER "/usr/bin/qutebrowser"
set -x PAGER "less"
set -x TERMINAL "kitty"
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"

set -x PATH "$PATH:$HOME/.local/bin"
set -x PATH "$PATH:$HOME/Dotfiles/bin"
set -x PATH "$PATH:$HOME/.gem/ruby/2.7.0/bin"
set -x PATH "$PATH:/usr/local/texlive/2019/bin/x86_64-linux"
set -x PATH "$PATH:/home/linuxbrew/.linuxbrew/bin"
set -x PATH "$PATH:$XDG_DATA_HOME/nvim/plugged/vim-iced/bin"

# Automatically start X11 in tty1
# -------------------------------
if systemctl -q is-active graphical.target \
  && test -z "$DISPLAY" \
       -a $XDG_VTNR -eq 1
  exec startx
end
