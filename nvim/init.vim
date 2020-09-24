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

set hidden         " :
set nobackup       " :
set nowritebackup  " : for coc.nvim
set updatetime=300 " :
set shortmess+=c   " :
set signcolumn=yes " :

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

vnoremap <leader>w :call EchoWc("-w", " words")<CR>
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

" Undotree {{{1
nnoremap <M-\> :UndotreeToggle<CR>:UndotreeFocus<CR>

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

" CtrlP {{{1
nnoremap <M-p> :CtrlPBuffer<CR>

" Tagbar {{{1
nnoremap <C-]> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

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

" coc.nvim {{{1
let g:coc_global_extensions = [
      \ "coc-git", "coc-explorer", "coc-yaml", "coc-vimlsp",
      \ "coc-texlab", "coc-python", "coc-json", "coc-rust-analyzer",
      \ "coc-ultisnips", "coc-word", "coc-html", "coc-tsserver",
      \ "coc-go", "coc-prettier", "coc-css"
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
nnoremap <leader>ar :Rename<CR>

" Remap for format selected region
xmap <leader>fs  <Plug>(coc-format-selected)
vmap <leader>fs  <Plug>(coc-format-selected)
nmap <leader>fs  mmvip<leader>fs`m

" Remap for format whole file
nmap <leader>ff  <Plug>(coc-format)

" Remap for format & save
nmap <leader>fw  <Plug>(coc-format):w<CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

" Using CocList
nnoremap <silent> ,a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> ,e  :<C-u>CocList extensions<cr>
nnoremap <silent> ,c  :<C-u>CocList commands<cr>
nnoremap <silent> ,o  :<C-u>CocList outline<cr>
nnoremap <silent> ,s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> ,j  :<C-u>CocNext<CR>
nnoremap <silent> ,k  :<C-u>CocPrev<CR>
nnoremap <silent> ,p  :<C-u>CocListResume<CR>

" Open explorer
nnoremap <C-\> :CocCommand explorer<CR>

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

nnoremap <leader>hh :AddHeader<CR>

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

" Clojure {{{1
let g:iced_enable_default_key_mappings = v:true
let g:iced_formatter = 'cljstyle'

" Haskell {{{1
let g:haskell_indent_disable = 1

" LaTeX {{{1
" NeoTex
let g:tex_flavor       = 'latex'
let g:neotex_enabled   = 1
let g:neotex_delay     = 250
let g:neotex_latexdiff = 0

autocmd FileType tex :NeoTexOn

" Markdown {{{1
let g:mkdx#settings = {
      \ 'highlight': { 'enable': 1 },
      \ 'enter': { 'shift': 1 },
      \ 'links': { 'external': { 'enable': 1 } },
      \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
      \ }
let g:polyglot_disabled = ['markdown']

let g:mkdp_auto_close = 0
let g:mkdp_browserfunc = 'OpenMKDP'
function OpenMKDP(url)
  exec "AsyncRun chromium '--app=" . a:url . "'"
endfunction

autocmd FileType markdown set syntax=pandoc
let g:pandoc#syntax#conceal#use = 0

" Build & Run {{{1
nnoremap <leader>rr :call build_and_run#run()<CR>
nnoremap <leader>bb :call build_and_run#build()<CR>

let g:build_and_run_setup = {
      \ "c": {
        \ "build":      "!(test -f '%:h/Makefile' || cmake '%:h') && make -f '%:h/Makefile'",
        \ "run":        "test -x '%:p:r' && %:p:r || '%:h/main'",
        \ "need_build": 1
        \ },
      \ "python": {
        \ "run":        "python3 '%:p'"
        \ },
      \ "javascript": {
        \ "run":        "node '%:p'"
        \ },
      \ "haskell": {
        \ "build":      "!stack build",
        \ "run":        "stack run"
        \ },
      \ "php": {
        \ "run":        "php -f '%:p'"
        \ },
      \ "lisp": {
        \ "run":        "clisp '%:p'"
        \ },
      \ "clojure": {
        \ "build":      "!lein uberjar",
        \ "run":        "lein run"
        \ },
      \ "scala": {
        \ "run":        "scala '%:p'"
        \ },
      \ "rust": {
        \ "build":      "!cargo build",
        \ "run":        "cargo run"
        \ },
      \ "go": {
        \ "run":        "go run '%:p'",
        \ "build":      "go build"
        \ },
      \ "cs": {
        \ "build":      "!dotnet build",
        \ "run":        "dotnet run"
        \ },
      \ "sh": {
        \ "run":        "sh '%:p'"
        \ },
      \ "fish": {
        \ "run":        "fish '%:p'"
        \ },
      \ "vim": {
        \ "run":        ":source %"
        \ },
      \ "xdefaults": {
        \ "run":        "!xrdb '%:p'"
        \ },
      \ "j": {
        \ "run":        "echo | j8 -c '%:p'"
        \ },
      \ "hy": {
        \ "run":        "hy '%:p'"
        \ }
      \ }

let g:build_and_run_setup["cpp"] = g:build_and_run_setup["c"]
" }}}1

" vim: fdm=marker
