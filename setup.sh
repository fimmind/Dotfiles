#! /usr/bin/env bash

need_upgrade=true
read -rN 1 -p "Do you want to run pacman update? [Y/n] " answer
if test "$answer" = "n" -o "$answer" = "N"; then
  need_upgrade=false
fi
echo

sudoers=$(sudo mktemp /etc/sudoers.d/dotmake_${USER}_XXXXXX) || exit
cleanup_exit() {
    sudo rm $sudoers &> /dev/null
    exit
}
trap cleanup_exit \
    SIGALRM SIGHUP SIGINT SIGIO \
    SIGKILL SIGPIPE SIGPROF SIGPWR \
    SIGSTKFLT SIGTERM EXIT ERR
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee $sudoers

if $need_upgrade; then
  sudo pacman-key --refresh-keys || true
  sudo pacman -Syu --noconfirm
fi

dotmake=./bin/dotmake
$dotmake install base_pkgs
if [ $# -eq 0 ]; then
    $dotmake install default
else
    $dotmake install $@
fi

cleanup_exit
