" Plugins loading {{{1
exec "source" . stdpath('config') . "/plugins.vim"

" Main settings {{{1
set colorcolumn=81
set textwidth=80
set splitright
set wrap
set hlsearch
set showmatch
set termencoding=utf-8
set fileencodings=utf-8,cp1251
set ch=1
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

" Basic mappings {{{1
command! Vimrc e ~/Dotfiles/nvim/init.vim

let g:maplocalleader=' '
let g:mapleader=' '

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap <leader>x :bdelete<CR>
nnoremap <leader>qq :q<CR>
nnoremap <leader>w <C-w>

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

command Wc call EchoWc("-w", " words")
function EchoWc(wc_args, postfix) range
  echo trim(
        \ system(
          \ 'echo ' . shellescape(join(getline(a:firstline, a:lastline), "\n"))
          \ .'| wc ' . a:wc_args))
        \ . a:postfix
endfunction

" Indentation {{{1
filetype indent on
set autoindent
set expandtab
autocmd FileType *
      \ set tabstop=2
      \ | set shiftwidth=2
      \ | set softtabstop=2
autocmd FileType cpp,c,python,rust
      \ set tabstop=4
      \ | set shiftwidth=4
      \ | set softtabstop=4

" Spell check {{{1
set spelllang=en,ru_yo
command! ToggleSpell let &spell = ! &spell

nnoremap <leader>st :ToggleSpell<CR>
nnoremap <leader>sp mm[s1z=`m
nnoremap <leader>sn mm]s1z=`m

autocmd FileType gitcommit,markdown,tex,text setlocal spell

" Terminal {{{1
tnoremap <Esc> <C-\><C-n>
autocmd TermOpen * setlocal nonumber norelativenumber

command! Shell vsplit term://fish | startinsert
nnoremap <leader>z :Shell<CR>

" NERDTree {{{1
nmap <C-\> :NERDTreeToggle<CR>

" Rainbow parentheseses {{{1
let g:rainbow_active = 1

let g:rainbow_conf = {
        \ 'operators': '_,_',
        \ 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
        \ 'separately': {
          \ 'cpp': 0,
          \ 'c': 0,
          \ 'markdown': 0,
          \ 'j': 0,
          \ 'yaml': 0,
          \ 'sxhkd': 0,
          \ 'haskell': {
            \ 'operators': '_,\|[-!#$%&\*\+/<=>\?@\\^|~:.]\+_',
            \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
          \ }
        \ }
      \ }

" Sheme {{{1
colorscheme gruvbox

" EasyMotion {{{1
nmap \ <Plug>(easymotion-prefix)

" Cosco {{{1
nmap <silent> <localleader>; <Plug>(cosco-commaOrSemiColon)

" vim-move {{{1
let g:move_key_modifier='C'

" splitjoin {{{1
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping  = ''
nmap <leader>J <Plug>SplitjoinJoin
nmap <leader>j <Plug>SplitjoinSplit

" Fugitive {{{1
nnoremap <leader>gg :G<CR>
nnoremap <leader>gw :Gw<CR>
nnoremap <leader>gl :G log<CR>

" Easy-align {{{1
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" Project-root {{{1
let g:rootmarkers = [
      \ '.projectroot', '.git', '.hg', '.svn', '.bzr', '_darcs', 'build.xml',
      \ 'main.tex', 'project.clj', 'deps.edn', 'package.yaml', 'stack.yaml'
      \ ]

" Templates {{{1
let g:templates_directory = stdpath("config") . "/templates"
let g:templates_no_builtin_templates = 1

" ALE {{{1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ }

let g:ale_linters_explicit = 1
let g:ale_linters = {
      \ 'clojure': ['joker']
      \ }

let g:ale_sign_warning = ">>"

" UltiSnips {{{1
let g:UltiSnipsEditSplit          ='vertical'
let g:UltiSnipsSnippetDirectories = ['UltiSnips']
let g:UltiSnipsUsePythonVersion   = 3

let g:UltiSnipsExpandTrigger       = "<Tab>"
let g:UltiSnipsJumpForwardTrigger  = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

" Lexima {{{1
autocmd FileType j let b:lexima_disabled = 1

" UltiSnips {{{2
call lexima#add_rule({
      \ 'char': '<CR>',
      \ 'filetype': 'snippets',
      \ 'at': '^snippet.*\%#\s*$',
      \ 'input_after': '<CR>endsnippet'
      \ })

" Haskell {{{2
let chars = {
      \ '-': ['{\%#}'],
      \ '#': ['{-\%#-}'],
      \ '<Space>': ['{-\%#-}', '{-#\%##-}']
      \ }

for char in keys(chars)
  for at in chars[char]
    call lexima#add_rule({
          \ 'filetype': 'haskell',
          \ 'char': char,
          \ 'at': at,
          \ 'input_after': char
          \ })
  endfor
endfor

for at in ['{-\%#-}', '{-#\%##-}', '{- \%# -}', '{-# \%# #-}']
  call lexima#add_rule({
        \ 'filetype': 'haskell',
        \ 'char': '<BS>',
        \ 'at': at,
        \ 'delete': 1
        \ })
endfor

call lexima#add_rule({
      \ 'filetype': 'haskell',
      \ 'char': '<CR>',
      \ 'at': '^{-\s*\%#\s*-}',
      \ 'syntax': 'Comment',
      \ 'input': '<CR> - ',
      \ 'input_after': '<CR>'
      \ })

call lexima#add_rule({
      \ 'filetype': 'haskell',
      \ 'char': '<CR>',
      \ 'at': '^{-.*\%#',
      \ 'syntax': 'Comment',
      \ 'input': '<CR> - '
      \ })

call lexima#add_rule({
      \ 'filetype': 'haskell',
      \ 'char': '<CR>',
      \ 'at': '^ -.*\%#',
      \ 'syntax': 'Comment',
      \ 'input': '<CR>- '
      \ })

" LaTeX {{{2
let pairs = {'(':')', '\\\\{':'\\\\}', '[':']', '<':'>'}
for i in keys(pairs)
  call lexima#add_rule({
        \ 'char': i[-1:],
        \ 'at': 'lr\%#',
        \ 'filetype': 'tex',
        \ 'input': '<BS><BS> <Esc>:call UltiSnips#Anon("\\left'.i.' $1 \\right'.pairs[i].'$0")<CR>'
        \ })
endfor

" HTML {{{2
call lexima#add_rule({
      \ 'char': '<CR>',
      \ 'filetype': 'html',
      \ 'at': '<[^/<>]*>\%#</[^<>]*>',
      \ 'input_after': '<CR>'
      \ })

" vim-header {{{1
let g:header_field_author = 'Vinogrodskii Serafim'
let g:header_field_author_email = 'fimmind@mail.ru'
let g:header_auto_add_header = 0
let g:header_field_license_id = 'MIT'
let g:header_alignment = 0

nnoremap <leader>ah :AddHeader<CR>

" NERDComment {{{1
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" Lisps {{{1
let g:sexp_enable_insert_mode_mappings = 1
let g:sexp_filetypes = 'clojure,scheme,lisp,timl,hy'
autocmd FileType clojure,scheme,lisp,timl,hy
      \ let b:lexima_disabled = 1
      \ | set lisp

" HTML {{{1
let g:user_emmet_mode='a'
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Rust {{{1
highlight link CocRustChainingHint CocCodeLens

" Haskell {{{1
let g:haskell_indent_disable = 1

" Markdown {{{1
let g:mkdx#settings = {
      \ 'highlight': { 'enable': 1 },
      \ 'enter': { 'shift': 1 },
      \ 'links': { 'external': { 'enable': 1 } },
      \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
      \ }
let g:polyglot_disabled = ['markdown']

autocmd FileType markdown set syntax=pandoc
let g:pandoc#syntax#conceal#use = 0

" Build & Run {{{1
nnoremap <leader>pr :call build_and_run#run()<CR>
nnoremap <leader>pb :call build_and_run#build()<CR>

" }}}1

" vim: fdm=marker
