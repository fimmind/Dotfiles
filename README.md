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

- Makefile:
  - Figure out how to run pamac command without of inserting password
- Setup pandoc like [that](https://learnbyexample.github.io/tutorial/ebook-generation/customizing-pandoc/)
- Exhaustive documentation (At least short description)
- System installation instructions
