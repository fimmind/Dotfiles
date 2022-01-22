" Basic settings {{{1
set colorcolumn=81
set textwidth=80
set wrap
set hlsearch
set showmatch
set termencoding=utf-8
set fileencodings=utf-8,cp1251
set cmdheight=1
set title
set wildmenu
set splitbelow
set showcmd
set number
set relativenumber
set ignorecase
set smartcase
set mouse=a
set shell=/bin/bash
set termguicolors
set background=dark
set foldmethod=marker
set exrc
set secure
filetype plugin on
filetype plugin indent on
syntax on
syntax sync fromstart

" Custom commands {{{1
command! Vimrc e ~/Dotfiles/nvim/init.vim

" General mappings {{{1
let g:maplocalleader=' '
let g:mapleader=' '

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap <leader>x :bdelete<CR>
nnoremap <leader>qq :q<CR>
nnoremap <leader>w <C-w>

nnoremap <leader>d :call DeleteNext(0)<CR>
nnoremap <leader>D :call DeleteNext(1)<CR>
function! DeleteNext(prev)
  if a:prev
    let l:motion = 'F'
  else
    let l:motion = 'f'
  endif
  exe "normal! mm" . l:motion . nr2char(getchar()) . "x`m"
endfunction

command Wc call EchoWordsCount("-w", " words")
function EchoWordsCount(wc_args, postfix) range
  echo trim(
        \ system(
          \ 'echo ' . shellescape(join(getline(a:firstline, a:lastline), "\n"))
          \ .'| wc ' . a:wc_args))
        \ . a:postfix
endfunction

" Tabs {{{1
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>ta :tabnew<CR>
nnoremap <leader>tf :tabfirst<CR>
nnoremap <leader>tl :tablast<CR>
nnoremap <leader>ts :tabs<CR>
nnoremap <leader>tq :tabclose<CR>
nnoremap <leader>to :tabonly<CR>
nnoremap <leader>tgr :2tabmove<CR>
nnoremap <leader>tgl :-1tabmove<CR>

" Indentation {{{1
filetype indent on
set autoindent
set expandtab
autocmd FileType *
      \ set tabstop=2
      \ | set shiftwidth=2
      \ | set softtabstop=2
autocmd FileType cpp,c,python,rust,tex
      \ set tabstop=4
      \ | set shiftwidth=4
      \ | set softtabstop=4

" Spell check {{{1
set spelllang=en,ru_yo
nnoremap <leader>st :let &spell=!&spell<CR>
nnoremap <leader>sp mm[s1z=`m
nnoremap <leader>sn mm]s1z=`m

autocmd FileType gitcommit,markdown,tex,text setlocal spell

" }}}1

" vim: fdm=marker
