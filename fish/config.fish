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


set MANPATH  "$MANPATH:/usr/local/texlive/2019/texmf-dist/doc/man"
set INFOPATH "$INFOPATH:/usr/local/texlive/2019/texmf-dist/doc/info"

if [ "`uname -o`" = "Android" ]
  alias chroot="termux-chroot && exit"
  alias hugs="termux-chroot hugs"
  alias runhugs="termux-chroot runhugs"
end

set fish_greeting

function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings insert
end
