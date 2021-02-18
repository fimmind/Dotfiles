#! /usr/bin/env bash

sudoers=$(sudo mktemp /etc/sudoers.d/dotmake_${USER}_XXXXXX) || exit
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee $sudoers

sudo pacman-key --refresh-keys
sudo pacman -Syu --noconfirm

dotmake install base_pkgs
if [ $# -eq 0 ]; then
    dotmake install DE pr_langs texlive
else
    dotmake install $@
fi

sudo rm $sudoers
