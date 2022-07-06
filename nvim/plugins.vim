" Download vim-plug if missing {{{1
let s:vim_plug_file = stdpath("data") . "/site/autoload/plug.vim"
function! UpdateVimPlug()
  echo "Updating vim-plug..."
  silent! exec "!curl --create-dirs -fsSLo " . s:vim_plug_file
        \ . " https://raw.github.com/junegunn/vim-plug/master/plug.vim"
endfunction

if empty(glob(s:vim_plug_file))
  call UpdateVimPlug()
endif

" }}}1

call plug#begin(stdpath('data') . '/plugged')
  " Coloring
  Plug 'EdenEast/nightfox.nvim'
  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/goyo.vim'

  " Tools
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-fugitive'
  Plug 'matze/vim-move'
  Plug 'andrewradev/splitjoin.vim'
  Plug 'nelstrom/vim-visual-star-search'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'markonm/traces.vim' " :substitute preview
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'cohama/lexima.vim'
  Plug 'wellle/targets.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'sirver/UltiSnips'
  Plug 'aperezdc/vim-template'
  Plug 'dense-analysis/ale'
  Plug 'easymotion/vim-easymotion'
  Plug 'guns/vim-sexp'
  Plug 'dkarter/bullets.vim'

  " Filetype
  Plug 'kovetskiy/sxhkd-vim'
  Plug 'dag/vim-fish'
  Plug 'lervag/vimtex'
  Plug 'bfrg/vim-cpp-modern'
  Plug 'rust-lang/rust.vim'
  Plug 'wlangstroth/vim-racket'
  Plug 'guersam/vim-j'
call plug#end()

" Automatically install missing plugins {{{1
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
   PlugInstall --sync | q
endif

" }}}1

" vim: fdm=marker
