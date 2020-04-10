alias ru="setxkbmap us,ru ,winkeys grp:caps_toggle"
alias fix_time="sudo ntpd -qg"
alias vimrc="nvim -c Vimrc"
alias getamsterdam="cp ~/Dotfiles/beamerthemeAmsterdam.sty ./"

set MANPATH  "$MANPATH:/usr/local/texlive/2019/texmf-dist/doc/man"
set INFOPATH "$INFOPATH:/usr/local/texlive/2019/texmf-dist/doc/info"

if [ "`uname -o`" = "Android" ]
  alias chroot="termux-chroot && exit"
  alias hugs="termux-chroot hugs"
  alias runhugs="termux-chroot runhugs"
end
