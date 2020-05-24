exec "source" . stdpath('config') . "/plugins.vim"

" Main
" ================================================
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
set mouse=a
set shell=/bin/bash
filetype plugin on
filetype plugin indent on

set hidden         " :
set nobackup       " :
set nowritebackup  " : for coc.nvim
set updatetime=300 " :
set shortmess+=c   " :
set signcolumn=yes " :

" Basic mappings
" ================================================
command! Vimrc e ~/Dotfiles/nvim/init.vim

let g:maplocalleader=' '
let g:mapleader=' '

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap gq :q<CR>
nnoremap gw :w<CR>

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

" Plugins mappings
" ================================================
" EasyMotion
nmap \ <Plug>(easymotion-prefix)

" Undotree
nnoremap <leader>u :UndotreeToggle<CR>:UndotreeFocus<CR>

" Cosco
nmap <silent> <localleader>; <Plug>(cosco-commaOrSemiColon)

" vim-move
let g:move_key_modifier='C'

" Fugitive
nnoremap <leader>gg :G<CR>
nnoremap <leader>gw :Gw<CR>
nnoremap <leader>gl :G log<CR>

" Easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" Spell check
" ================================================
set spelllang=en,ru_yo
command! ToggleSpell let &spell = ! &spell

nnoremap <leader>st :ToggleSpell<CR>
nnoremap <leader>sp mm[s1z=`m
nnoremap <leader>sn mm]s1z=`m

autocmd FileType gitcommit,markdown,tex,text setlocal spell

" Tagbar
" ================================================
nnoremap <C-]> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Project-root
" ================================================
let g:rootmarkers = [
      \ '.projectroot', '.git', '.hg', '.svn', '.bzr', '_darcs', 'build.xml',
      \ 'main.tex', 'project.clj', 'deps.edn', 'package.yaml', 'stack.yaml'
      \ ]

" Templates
" ================================================
let g:templates_directory = stdpath("config") . "/templates"
let g:templates_no_builtin_templates = 1

" ALE
" ================================================
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ }

let g:ale_linters_explicit = 1
let g:ale_linters = {
      \ 'clojure': ['joker']
      \ }

let g:ale_sign_warning = ">>"

" CoC
" ================================================
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

" UltiSnips
" ================================================
let g:UltiSnipsEditSplit          ='vertical'
let g:UltiSnipsSnippetDirectories = ['UltiSnips']
let g:UltiSnipsUsePythonVersion   = 3

let g:UltiSnipsExpandTrigger       = "<Tab>"
let g:UltiSnipsJumpForwardTrigger  = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

" HTML
" ================================================
let g:user_emmet_mode='a'
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Terminal
" ================================================
tnoremap <Esc> <C-\><C-n>
autocmd TermOpen * setlocal nonumber norelativenumber

command! Shell vsplit term://fish | startinsert
nnoremap <leader>z :Shell<CR>

" Rainbow parentheseses
" ================================================
let g:rainbow_active = 1

let g:rainbow_conf = {
        \ 'operators': '_,_',
        \ 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
        \ 'separately': {
          \ 'cpp': 0,
          \ 'c': 0,
          \ 'markdown': 0,
          \ 'haskell': {
            \ 'operators': '_,\|[-!#$%&\*\+/<=>\?@\\^|~:.]\+_',
            \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold'],
          \ }
        \ }
      \ }

" Clojure
" ================================================
autocmd FileType lisp,clojure let b:lexima_disabled = 1

let g:iced_enable_default_key_mappings = v:true
let g:iced_formatter = 'cljstyle'

let g:sexp_enable_insert_mode_mappings = 1

" Haskell
" ================================================
let g:haskell_indent_if = 2
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = -1
let g:haskell_indent_after_bare_where = 1
let g:haskell_indent_do = 3
let g:haskell_indent_in = 0
let g:haskell_indent_guard = 2

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

" Indentation
" ================================================
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

" Theme
" ================================================
set termguicolors
let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox
set background=dark
syntax on
syntax sync fromstart

" LaTeX
" ================================================
" TODO: move to snippets
let pairs = {'(':')', '\\\\{':'\\\\}', '[':']', '<':'>'}
for i in keys(pairs)
  call lexima#add_rule({
        \ 'char': i[-1:],
        \ 'at': 'lr\%#',
        \ 'filetype': 'tex',
        \ 'input': '<BS><BS> <Esc>:call UltiSnips#Anon("\\left'.i.' $1 \\right'.pairs[i].'$0")<CR>'
        \ })
endfor

" NeoTex
let g:tex_flavor       = 'latex'
let g:neotex_enabled   = 1
let g:neotex_delay     = 250
let g:neotex_latexdiff = 0

autocmd FileType tex :NeoTexOn

" Markdown
" ================================================
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

" NERDComment
" ================================================
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" Build & Run
" ================================================
nnoremap <leader>rr :call build_and_run#run()<CR>
nnoremap <leader>bb :call build_and_run#build()<CR>

let g:build_and_run_setup = {
      \ "c": {
        \ "build":      "!test -f '%:h/Makefile'; or cmake '%:h'; and make -f '%:h/Makefile'",
        \ "run":        "test -x '%:p:r'; and %:p:r; or '%:h/main'",
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
        \ "run":        "stack test && clear && stack run"
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
        \ "build":      "!cargo build --release",
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
        \ }
      \ }

let g:build_and_run_setup["cpp"] = g:build_and_run_setup["c"]
