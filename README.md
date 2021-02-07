# Fimmind's Dotfiles

## Installation

! ATTENTION ! This script isn't meant to be used by anyone but me. There is
absolutely no guarantee that it won't break your system or something like that.
Be very careful using it

```shell
$ cd ~                 # Some scripts and settings rely on such Dotfiles' location
$ git clone https://github.com/fimmind/Dotfiles
$ cd Dotfiles
$ sudo pacman-key --refresh-keys  # ┬ Not needed, if you are sure, that keys or
$ sudo pacman -Syu --noconfirm    # ┘    packages are up to date
$ make
$ make installTexLive  # This takes a long while and much space,
$                      #    therefore it's optional
$ chsh -s /usr/bin/fish
```

### GTK theme

Use `lxappearance`:

- Widget: Plata-Noir
- Icon: Papirus
- Mouse cursor: Breeze

## Fixes for some problems

### Enable automatic bluetooth activation
Set following in `/etc/bluetooth/main.conf`:
```conf
[Policy]
AutoEnable=true
```

### Fix gpg's `General error <Unspecified source>`

```
# Add this to /etc/pacman.d/gnupg/gpg.conf
keyserver hkps://hkps.pool.sks-keyservers.net
keyserver-options no-honor-keyserver-url

# and this to /etc/pacman.d/gnupg/dirmngr.conf
hkp-cacert /usr/share/gnupg/sks-keyservers.netCA.pem
```

### Make functional keys default on Logitech k380
Use this: https://github.com/jergusg/k380-function-keys-conf

## TODO
- Exhaustive dotfiles documentation (At least short description)
- System installation instructions
- Setup emacs daemon for seledit. [Original setup](https://github.com/fimmind/Dotfiles/commit/1f91dc578a460236df412077d5ef98c234d1fdd4)
  worked fine, but Now `emacs --daemon` always crashes "due to a long standing Gtk+ bug". As stated
  [here](https://gitlab.gnome.org/GNOME/gtk/issues/221) the solution might be to downgrade emacs-27 to emacs-26
