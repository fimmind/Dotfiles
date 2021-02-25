#! /usr/bin/env bash

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

sudo pacman-key --refresh-keys || true
sudo pacman -Syu --noconfirm

dotmake=./bin/dotmake
$dotmake install base_pkgs
if [ $# -eq 0 ]; then
    $dotmake install default
else
    $dotmake install $@
fi

cleanup_exit
