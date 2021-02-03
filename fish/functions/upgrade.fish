function upgrade_sudo
    pacman-key --refresh-keys
    pacman -Syyuu --noconfirm
    tlmgr update --self --all --reinstall-forcibly-removed
    npm upgrade
    updatedb
end

function upgrade_no_sudo
    brew update
    brew upgrade
    stack upgrade
    doom upgrade

    nvim -u "~/Dotfiles/nvim/plugins.vim" -c "call UpdateVimPlug() | :PlugUpdate | :qa"
end

function sudo_run
    set fname (status -f)
    sudo -- fish -c "source $fname && $argv"
end

function upgrade
    echo "Running system upgrade"
    sudo_run upgrade_sudo && upgrade_no_sudo
end
