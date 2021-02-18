#! /usr/bin/env bash

sudoers=$(sudo mktemp /etc/sudoers.d/dotmake_${USER}_XXXXXX) || exit
echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee $sudoers

if [ $# -eq 0 ]; then
    sudo pacman-key --refresh-keys
    sudo pacman -Suy --noconfirm
    dotmake install base_pkgs && sudo ldconfig && \
        dotmake install DE pr_langs
else
    dotmake install base_pkgs && \
        dotmake install $@
fi

sudo rm $sudoers
