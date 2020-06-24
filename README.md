# Fimmind's Dotfiles

## Installation

```shell
$ cd ~                 # Some scripts and settings rely on such Dotfiles' location
$ git clone https://github.com/fimmind/Dotfiles
$ cd Dotfiles
$ sudo pacman-key --refresh-keys  # ┬ Not needed, if you are sure, that keys or
$ sudo pacman -Syu --noconfirm    # ┘    packages are up to date
$ make
$ make installTexLive  # This takes a long while and much space,
$                      #    therfore it's optional
$ chsh -s /usr/bin/fish
```

### GTK theme

Use `lxappearance`:

- Widget: Plata-Noir
- Icon: Papirus
- Mouse cursor: Breeze

### Enable auto power-on of bluetooth after a boot
Set following in `/etc/bluetooth/main.conf`:
```conf
[Policy]
AutoEnable=true
```

### Make functional keys default on Logitech k380
Use this: https://github.com/jergusg/k380-function-keys-conf

## TODO

- Makefile:
  - Figure out how to run pamac command without of inserting password
- Setup pandoc like [that](https://learnbyexample.github.io/tutorial/ebook-generation/customizing-pandoc/)
- Exhaustive documentation (At least short description)
- System installation instructions
- Setup windows layout using [this](https://i3wm.org/docs/layout-saving.html) article
- (Neo)Vim:
  - Try [flow](https://github.com/neoclide/coc.nvim/wiki/Language-servers#flow)
    for js
  - Setup `Joker` linting with
    [efm-langserver](https://github.com/mattn/efm-langserver) and `coc.nvim`
    instead of ALE
  - Same mappings for vim-iced and ALE as for coc.nvim
  - General REPL mapping. Maybe with [vim-repl](https://github.com/sillybun/vim-repl)
  - Setup coc-eslint
  - Try to setup and use [floskell](https://github.com/ennocramer/floskell)

## Thanks

- Many LaTeX snippets have been taken from [here](https://github.com/gillescastel/latex-snippets).
