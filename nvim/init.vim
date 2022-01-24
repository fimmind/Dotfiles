" Plugins loading {{{1
exec "source" . stdpath('config') . "/plugins.vim"

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
command! Vimrc exec "e " . stdpath('config') . "/init.vim"

" General mappings {{{1
let g:maplocalleader=','
let g:mapleader=' '
let maplocalleader=g:maplocalleader
let mapleader=g:mapleader

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>qq :q<CR>
nnoremap <leader>w <C-w>

noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>P "+P
noremap <leader>x "+x

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

" Color scheme {{{1
colorscheme nordfox

" NERDCommenter {{{1
let g:NERDSpaceDelims = 1

" Fugitive (git) {{{1
nnoremap <leader>gg :G<CR>
nnoremap <leader>gl :G log<CR>
nnoremap <leader>gc :Gcd<CR>

" NERDTree {{{1
nmap <leader>, :NERDTreeFocus<CR>

" splitjoin {{{1
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping  = ''
nmap <leader>J <Plug>SplitjoinJoin
nmap <leader>j <Plug>SplitjoinSplit

" Easy-align {{{1
nmap <leader>a <Plug>(EasyAlign)
xmap <leader>a <Plug>(EasyAlign)

" UltiSnips {{{1
let g:UltiSnipsSnippetDirectories = ['UltiSnips']
let g:UltiSnipsUsePythonVersion   = 3

let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

call lexima#add_rule({
      \ 'char': '<CR>',
      \ 'filetype': 'snippets',
      \ 'at': '^snippet.*\%#\s*$',
      \ 'input_after': '<CR>endsnippet'
      \ })

" vim-template {{{1
let g:templates_directory = stdpath("config") . "/templates"
let g:templates_no_builtin_templates = 1

" VimTeX {{{1
let g:vimtex_view_method = 'zathura'

" coc.nvim {{{1
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorMoved
autocmd CursorMoved * silent call CocActionAsync('highlight')

" Remap for rename current word
command! Rename normal <Plug>(coc-rename)
nnoremap <leader>lr :Rename<CR>

" Remap for format selected region
xmap <leader>ls  <Plug>(coc-format-selected)
vmap <leader>ls  <Plug>(coc-format-selected)
nmap <leader>ls  mmvip<leader>ls`m

" Remap for format whole file
nmap <leader>lf  <Plug>(coc-format)

" Remap for format & save
nmap <leader>lw  <Plug>(coc-format):w<CR>

augroup mygroup
  autocmd!
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of current line
nmap <leader>la  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>lq  <Plug>(coc-fix-current)

xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)

" Remap for CocList
nnoremap <silent> <leader>lla  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>lle  :<C-u>CocList extensions<cr>
nnoremap <silent> <leader>llc  :<C-u>CocList commands<cr>
nnoremap <silent> <leader>llo  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>lls  :<C-u>CocList -I symbols<cr>

" {{{1 vim: fdm=marker
