# Fimmind's Dotfiles

## Installation

! ATTENTION ! This script isn't meant to be used by anyone but me. There is
absolutely no guarantee that it won't break your system or something like that.
Be very careful using it.

```shell
git clone https://github.com/fimmind/Dotfiles ~/Dotfiles
cd Dotfiles
./setup.sh
```

### GTK theme

Use `lxappearance`:

- Widget: Plata-Noir
- Icon: Papirus
- Mouse cursor: Breeze

### KataGo

1. Install [katago-cpu](https://aur.archlinux.org/packages/katago-cpu/) or [katago-opencli](https://aur.archlinux.org/packages/katago-opencl/). Use OpenCL if you have any good or decent GPU. Otherwise CPU version is preferable.
2. [Setup](https://github.com/lightvector/KataGo#how-to-use) the engine.
3. Add KataGo to Sabaki at `File > Preferences > Engines`:
   - Path: `/usr/bin/katago`;
   - Arguments: `gtp`;
   - Initial commands: `time_settings 0 5 1`.

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
