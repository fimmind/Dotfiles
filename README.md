# Dotfiles
## Installation
```shell
$ cd ~  # Some scripts and settings rely on this Dotfiles' location
$ git clone https://github.com/fimmind/Dotfiles
$ cd Dotfiles
$ make
```

## GTK theme
Use `lxappearance`:
* Widget: Plata-Noir
* Icon: Papirus
* Mouse cursor: Breeze

## TODO
* Exhaustive documentation
* System installation instructions
* Setup default applications
* Try to learn boot and use it instead of leiningen (Maybe it will fix conjure completion for packages add as dependencies)
* (Neo)Vim:
  * Move init.vim parts related to specific languages to ftplugin/<language\_filetype>.vim
  * Fix haskell `module` snippet (It ignores path to module right now)
  * Try to setup and use [floskell](https://github.com/ennocramer/floskell)
  * Try [command-t](https://github.com/wincent/command-t) instead of ctrl-p
  * General REPL mapping
  * Setup clj-kondo-lsp and connect it to coc.nvim instead of using clj-kondo with ALE
    https://github.com/borkdude/clj-kondo/blob/master/doc/editor-integration.md 

## Thanks
* Many LaTeX snippets have been taken from [here](https://github.com/gillescastel/latex-snippets).
