call plug#begin(stdpath('data') . '/plugged')
  " Coloring
  Plug 'phaazon/gruvbox' " Not original, cause of haskell-vim support
  Plug 'gko/vim-coloresque'
  Plug 'oblitum/rainbow', { 'for': ['cpp', 'c'], 'as': 'rainbow-cpp' }
  Plug 'luochen1990/rainbow'

  " Motion
  Plug 'matze/vim-move'
  Plug 'easymotion/vim-easymotion'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'wellle/targets.vim'

  " Tools
  Plug 'junegunn/vim-easy-align'
  Plug 'markonm/traces.vim'                " :substitute preview
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
  Plug 'lfilho/cosco.vim'
  Plug 'KabbAmine/vCoolor.vim'
  Plug 'cohama/lexima.vim'
  Plug 'guns/vim-sexp'
  Plug 'mattn/emmet-vim'
  Plug 'sirver/UltiSnips'
  Plug 'alpertuna/vim-header'

  " IDE
  " ================================================
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'dense-analysis/ale'
  Plug 'majutsushi/tagbar'
  Plug 'aperezdc/vim-template'

  " Syntax
  Plug 'suy/vim-qmake'
  Plug 'justinmk/vim-syntax-extra'
  Plug 'PotatoesMaster/i3-vim-syntax'
  Plug 'vim-airline/vim-airline'
  Plug 'dag/vim-fish'
  Plug 'cespare/vim-toml'
  Plug 'isruslan/vim-es6'
  Plug 'neovimhaskell/haskell-vim'
  Plug 'vim-pandoc/vim-pandoc-syntax'

  " Rust
  Plug 'rust-lang/rust.vim'

  " Clojure
  Plug 'liquidz/vim-iced', {'for': 'clojure'}
  Plug 'liquidz/vim-iced-coc-source', {'for': 'clojure'}

  " Haskell
  Plug 'alx741/vim-stylishask'
  Plug 'fimmind/vim-hs-type'
  Plug 'feuerbach/vim-hs-module-name'
  Plug 'itchyny/vim-haskell-indent'

  " Markdown
  Plug 'SidOfc/mkdx'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

  " LaTeX
  Plug 'donRaphaco/neotex', { 'for': 'tex' }

call plug#end()

" Automatically install missing plugins
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
   PlugInstall --sync | q
endif
