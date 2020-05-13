# Dotfiles

## Installation
```shell
$ cd ~                 # Some scripts and settings rely on this Dotfiles' location
$ git clone https://github.com/fimmind/Dotfiles
$ cd Dotfiles
$ make                 # Enter your password when asked
$ make installTexLive  # This takes a long while, therfore it's optional
```

## GTK theme
Use `lxappearance`:
* Widget: Plata-Noir
* Icon: Papirus
* Mouse cursor: Breeze

## TODO
* Makefile:
  * Test if full installation works fine
  * Figure out how to make installation more automatic (Now there are many
    places where you have to, for example, input your password, and, since
    installation takes a while, it should be allowed to leave a computer without
    of a risk to return back and find out that the computer waits for your
    confirmation and stays doing nothing)
* Setup pandoc like [that](https://learnbyexample.github.io/tutorial/ebook-generation/customizing-pandoc/)
* Exhaustive documentation (At least short description)
* System installation instructions
* Setup default applications
* Setup windows layout using [this](https://i3wm.org/docs/layout-saving.html) article
* (Neo)Vim:
  * Try [flow](https://github.com/neoclide/coc.nvim/wiki/Language-servers#flow)
    for js
  * Try [vim-lion](https://github.com/tommcdo/vim-lion) instead of
    vim-easy-motion
  * Setup `Joker` linting with
    [efm-langserver](https://github.com/mattn/efm-langserver) and `coc.nvim`
    instead of ALE
  * Same mappings for vim-iced and ALE as for coc.nvim
  * General REPL mapping. Maybe with [vim-repl](https://github.com/sillybun/vim-repl)
  * Setup coc-eslint
  * Try to setup and use [floskell](https://github.com/ennocramer/floskell)

## Thanks
* Many LaTeX snippets have been taken from [here](https://github.com/gillescastel/latex-snippets).
