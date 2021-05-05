" Download vim-plug if missing {{{
let s:vim_plug_file = stdpath("data") . "/site/autoload/plug.vim"
function! UpdateVimPlug()
  echo "Updating vim-plug..."
  silent! exec "!curl --create-dirs -fsSLo " . s:vim_plug_file
        \ . " https://raw.github.com/junegunn/vim-plug/master/plug.vim"
endfunction

if empty(glob(s:vim_plug_file))
  call UpdateVimPlug()
endif
" }}}

call plug#begin(stdpath('data') . '/plugged')
  " Coloring
  Plug 'phaazon/gruvbox' " Not original, cause of haskell-vim support
  Plug 'gko/vim-coloresque'
  Plug 'oblitum/rainbow', { 'for': ['cpp', 'c'], 'as': 'rainbow-cpp' }
  Plug 'luochen1990/rainbow'

  " Motion
  Plug 'matze/vim-move'
  Plug 'easymotion/vim-easymotion'
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
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-fold'
  Plug 'tpope/vim-fugitive'
  Plug 'dbakker/vim-projectroot'
  Plug 'nelstrom/vim-visual-star-search'
  Plug 'lfilho/cosco.vim'
  Plug 'cohama/lexima.vim'
  Plug 'guns/vim-sexp'
  Plug 'mattn/emmet-vim'
  Plug 'sirver/UltiSnips'
  Plug 'alpertuna/vim-header'
  Plug 'andrewradev/splitjoin.vim'
  Plug 'preservim/nerdtree'
  Plug 'dense-analysis/ale'
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
  Plug 'hylang/vim-hy'
  Plug 'kovetskiy/sxhkd-vim'
  Plug 'leafgarland/typescript-vim'

  " Rust
  Plug 'rust-lang/rust.vim'

  " Haskell
  Plug 'itchyny/vim-haskell-indent'

  " Markdown
  Plug 'SidOfc/mkdx'
  Plug 'dhruvasagar/vim-table-mode'

call plug#end()

" Automatically install missing plugins
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
   PlugInstall --sync | q
endif
