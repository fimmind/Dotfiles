call plug#begin(stdpath('data') . '/plugged')
  " Syntax, style
  Plug 'phaazon/gruvbox' " Not original, couse of haskell-vim support
  Plug 'suy/vim-qmake'
  Plug 'justinmk/vim-syntax-extra'
  Plug 'PotatoesMaster/i3-vim-syntax'
  Plug 'vim-airline/vim-airline'

  " Clojure
  Plug 'Olical/conjure', { 'tag': 'v2.1.2', 'do': 'bin/compile' }

  " Lisp
  Plug 'guns/vim-sexp'
  Plug 'eraserhd/parinfer-rust', { 'do': 'cargo build --release' }

  " Haskell
  Plug 'neovimhaskell/haskell-vim'
  Plug 'alx741/vim-stylishask'
  Plug 'fimmind/vim-hs-type'

  " Markdown
  Plug 'SidOfc/mkdx'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

  " Html
  Plug 'mattn/emmet-vim'

  " LaTeX
  Plug 'donRaphaco/neotex', { 'for': 'tex' }

  " C++
  Plug 'oblitum/rainbow', { 'for': ['cpp', 'c'], 'as': 'rainbow-cpp' }

  " Python
  Plug 'tweekmonster/braceless.vim' " TODO: learn

  " Tools
  Plug 'junegunn/vim-easy-align'
  Plug 'markonm/traces.vim'                " :substitute prewiew
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'scrooloose/nerdcommenter'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'KorySchneider/vim-trim'
  Plug 'tpope/vim-fugitive'                " TODO: learn
  Plug 'dbakker/vim-projectroot'
  Plug 'vim-scripts/vim-auto-save'

  " Motion
  Plug 'matze/vim-move'
  Plug 'easymotion/vim-easymotion'
  Plug 'ctrlpvim/ctrlp.vim'

  " IDE
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'cohama/lexima.vim'
  Plug 'sirver/UltiSnips'
  Plug 'luochen1990/rainbow'
call plug#end()
