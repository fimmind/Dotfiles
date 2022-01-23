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

" List the plugins {{{1
call plug#begin(stdpath('data') . '/plugged')
  " Coloring
  Plug 'EdenEast/nightfox.nvim'

  " Tools
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-fugitive'
  Plug 'matze/vim-move'
  Plug 'preservim/nerdtree'
  Plug 'andrewradev/splitjoin.vim'
  Plug 'nelstrom/vim-visual-star-search'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'markonm/traces.vim' " :substitute preview
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'cohama/lexima.vim'
  Plug 'wellle/targets.vim'
  Plug 'junegunn/vim-easy-align'

  " Filetype
  Plug 'kovetskiy/sxhkd-vim'
  Plug 'dag/vim-fish'
call plug#end()

" Automatically install missing plugins {{{1
if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
   PlugInstall --sync | q
endif

" }}}1 

" vim: fdm=marker
