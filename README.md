# Dotfiles

## Installation
```shell
$ cd ~  # Some scripts and settings rely on this Dotfiles' location
$ git clone https://github.com/fimmind/Dotfiles
$ cd Dotfiles
$ make # Enter super user's password when asked
```

## GTK theme
Use `lxappearance`:
* Widget: Plata-Noir
* Icon: Papirus
* Mouse cursor: Breeze

## TODO
* Setup pandoc like [that](https://learnbyexample.github.io/tutorial/ebook-generation/customizing-pandoc/)
* Replacements:
  * i3status -> i3blocks
  * kitty -> st (simple terminal)
* Exhaustive documentation
* System installation instructions
* Setup default applications
* Setup windows layout using [this](https://i3wm.org/docs/layout-saving.html) article
* (Neo)Vim:
  * Setup `Joker` linting with
    [efm-langserver](https://github.com/mattn/efm-langserver) and `coc.nvim`
    instead of ALE
  * Same mappings for vim-iced and ALE as for coc.nvim
  * General REPL mapping. Maybe with [vim-repl](https://github.com/sillybun/vim-repl)
  * Setup coc-eslint
  * Fix haskell `module` snippet (It ignores path to module right now)
  * Try to setup and use [floskell](https://github.com/ennocramer/floskell)

## Thanks
* Many LaTeX snippets have been taken from [here](https://github.com/gillescastel/latex-snippets).
