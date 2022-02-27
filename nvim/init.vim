" Plugins loading {{{1
exec "source" . stdpath('config') . "/plugins.vim"

" Basic settings {{{1
set colorcolumn=81
set textwidth=80
set wrap linebreak
set scrolloff=10
set list
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
set formatoptions-=tc
set exrc
set secure
filetype plugin on
filetype plugin indent on
syntax on
syntax sync fromstart

" Custom commands {{{1
command! Vimrc exec "e " . stdpath('config') . "/init.vim"

" General mappings {{{1
let g:maplocalleader=' z'
let g:mapleader=' '
let maplocalleader=g:maplocalleader
let mapleader=g:mapleader

noremap j gj
noremap k gk
noremap gj j
noremap gk k
inoremap <c-l> <tab>

nnoremap <leader>w <C-w>

noremap <leader>y "+y
noremap <leader>p "+p
noremap <leader>P "+P
noremap <leader>x "+x

nnoremap <silent> <leader>r :w\|!make -f nvim.mk VIM_CUR_BUF_FILE="%:p" nvim/run<cr>
nnoremap <silent> <leader>b :w\|!make -f nvim.mk VIM_CUR_BUF_FILE="%:p" nvim/build<cr>
nnoremap <silent> <leader>m :w\|!make VIM_CUR_BUF_FILE="%:p"<cr>

nnoremap <silent> <leader>d :exe "normal! mmf" . nr2char(getchar()) . "x`m"<cr>
nnoremap <silent> <leader>D :exe "normal! mmF" . nr2char(getchar()) . "x`m"<cr>

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
nnoremap <leader>se :setlocal spelllang=en<cr>
nnoremap <leader>sr :setlocal spelllang=ru_yo<cr>
nnoremap <leader>sc :setlocal spelllang=en,ru_yo<cr>
nnoremap <leader>sp mm[s1z=`m
nnoremap <leader>sn mm]s1z=`m

autocmd FileType gitcommit,markdown,tex,text setlocal spell

" Status line {{{1
function s:left_block()
  let l:mode = mode()
  let l:branch = FugitiveHead(7)
  let l:fname = '%f%m'

  return [l:mode, l:branch, l:fname]
endfunction

function s:right_block()
  let l:coc_status = coc#status()
  let l:spelllang = ""
  if &spell
    let l:spelllang = &spelllang
  endif
  let l:ftype = &filetype
  let l:lines = '≡%L'
  let l:cursor = '%l-%c'

  return [l:coc_status, l:spelllang, l:ftype, l:lines, l:cursor]
endfunction

function s:join_modules(modules)
  return a:modules
        \ ->filter('strlen(v:val) > 0')
        \ ->join(' · ')
endfunction

function s:join_blocks(blocks)
  return a:blocks
        \ ->map('s:join_modules(v:val)')
        \ ->join('%=')
endfunction

function Statusline()
  return ' ' . s:join_blocks([
        \ s:left_block(),
        \ s:right_block()
      \ ]) . ' '
endfunction
set statusline=%!Statusline()

" Color scheme {{{1
colorscheme nordfox

" NERDCommenter {{{1
let g:NERDSpaceDelims = 1

" Fugitive (git) {{{1
nnoremap <leader>gg :G<CR>
nnoremap <leader>gl :G log<CR>
nnoremap <leader>gc :Gcd<CR>

" lexima {{{1
for i in [')', '}', ']']
  call lexima#add_rule({
        \ 'char': i,
        \ 'at': '\%#\s*'.i,
        \ 'input': '<esc>f'.i.'a'
        \ })
endfor

" splitjoin {{{1
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping  = ''
nmap <leader>J <Plug>SplitjoinJoin
nmap <leader>j <Plug>SplitjoinSplit

" Easy-align {{{1
nmap <leader>a <Plug>(EasyAlign)
xmap <leader>a <Plug>(EasyAlign)

" UltiSnips {{{1
command! UltisnipsRefreshSnippets call UltiSnips#RefreshSnippets()

let g:UltiSnipsSnippetDirectories = ['UltiSnips']
let g:UltiSnipsUsePythonVersion   = 3
let g:UltiSnipsEditSplit          = "context"

let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

call lexima#add_rule({
      \ 'char': '<CR>',
      \ 'filetype': 'snippets',
      \ 'at': '^snippet.*\%#\s*$',
      \ 'input_after': '<CR>endsnippet'
      \ })
call lexima#add_rule({
      \ 'char': '<CR>',
      \ 'filetype': 'snippets',
      \ 'at': '^global.*\%#\s*$',
      \ 'input_after': '<CR>endglobal'
      \ })

" vim-template {{{1
let g:templates_directory = stdpath("config") . "/templates"
let g:templates_no_builtin_templates = 1

let g:templates_user_variables = [
      \ ["TEX_PRELUDE", "FindTexPrelude"]
      \ ]

" Finds the closest `prelude.tex` file and returns its path relative to the
" current file. Returns an empty string if no `prelude.tex` is found in any of
" the parent directories
let g:tex_prelude_fname = "prelude.tex"
function! FindTexPrelude()
  let l:source_dir = expand("%:p:h") . "/"
  let l:search_dir = ""
  while isdirectory(l:source_dir . l:search_dir)
    if filereadable(l:source_dir . l:search_dir . g:tex_prelude_fname)
      return l:search_dir . g:tex_prelude_fname
    endif
    let l:search_dir = l:search_dir . "../"
  endwhile
  return ""
endfunction

" VimTeX {{{1
let g:vimtex_view_method = 'zathura'
let g:vimtex_imaps_leader = ';'
let g:vimtex_env_toggle_math_map = {
      \ '$': '\(',
      \ '\(': '\[',
      \ '$$': '\[',
      \ '\[': 'equation',
      \ 'equation': '\('
      \ }
let g:vimtex_quickfix_ignore_filters = [
      \ 'Underfull',
      \ 'Overfull',
      \ ]

" coc.nvim {{{1
set encoding=utf-8
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes

let g:coc_global_extensions = [
      \ "coc-json", "coc-git", "coc-ultisnips", "coc-vimtex", "coc-prettier",
      \ "coc-explorer", "coc-jedi", "coc-rust-analyzer"
      \ ]
function InstallCocExtensions()
  exec "CocInstall -sync " . join(g:coc_global_extensions)
endfunction

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
vmap <leader>lf  <Plug>(coc-format-selected)
nmap <leader>lf  <Plug>(coc-format-selected)

" Remap for format whole file
nmap <leader>lF  <Plug>(coc-format)

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

" Remap for coc-explorer
nmap <silent> <leader>, :CocCommand explorer<CR>

" ALE {{{1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'python': ['autopep8', 'yapf'],
      \ 'rust': ['rustfmt']
      \ }
let g:ale_fix_on_save_ignore = {
      \ 'snippets': ['trim_whitespace']
      \ }

let g:ale_lint_on_text_changed = 'always'
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \ 'tex': ['chktex', 'lacheck'],
      \ 'python': ['flake8', 'bandit', 'pylint']
      \ }

let g:ale_sign_warning = ">>"

" easymotion {{{1
nmap <leader>s <Plug>(easymotion-prefix)

" {{{1 vim: fdm=marker
