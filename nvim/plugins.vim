call plug#begin(stdpath('data') . '/plugged')
  " Syntax, style
  Plug 'phaazon/gruvbox' " Not original, cause of haskell-vim support
  Plug 'suy/vim-qmake'
  Plug 'justinmk/vim-syntax-extra'
  Plug 'PotatoesMaster/i3-vim-syntax'
  Plug 'vim-airline/vim-airline'
  Plug 'dag/vim-fish'
  Plug 'cespare/vim-toml'

  " Lisp
  Plug 'guns/vim-sexp'

  " Clojure
  Plug 'liquidz/vim-iced', {'for': 'clojure'}
  Plug 'liquidz/vim-iced-coc-source', {'for': 'clojure'}

  " Haskell
  Plug 'neovimhaskell/haskell-vim'
  Plug 'alx741/vim-stylishask'
  Plug 'fimmind/vim-hs-type'
  Plug 'feuerbach/vim-hs-module-name'

  " Markdown
  Plug 'SidOfc/mkdx'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
  Plug 'vim-pandoc/vim-pandoc-syntax'

  " Html
  Plug 'mattn/emmet-vim'

  " JavaScript
  Plug 'lfilho/cosco.vim'

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
  Plug 'tpope/vim-fugitive'
  Plug 'dbakker/vim-projectroot'
  Plug 'vim-scripts/vim-auto-save'
  Plug 'mbbill/undotree'
  Plug 'junegunn/vim-peekaboo'
  Plug 'nelstrom/vim-visual-star-search'

  " Motion
  Plug 'matze/vim-move'
  Plug 'easymotion/vim-easymotion'
  Plug 'ctrlpvim/ctrlp.vim'

  " IDE
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'cohama/lexima.vim'
  Plug 'sirver/UltiSnips'
  Plug 'luochen1990/rainbow'
  Plug 'dense-analysis/ale'
call plug#end()
