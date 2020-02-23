call plug#begin('~/.config/nvim/plugged')
  " Syntax, style
  Plug 'phaazon/gruvbox' " Not original, couse of haskell-vim support
  Plug 'suy/vim-qmake'
  Plug 'justinmk/vim-syntax-extra'
  Plug 'PotatoesMaster/i3-vim-syntax'

  " Clojure
  Plug 'tpope/vim-fireplace' " TODO: learn
  Plug 'guns/vim-sexp'       " TODO: learn

  " Lisp
  Plug 'eraserhd/parinfer-rust', { 'do': 'cargo build --release' }

  " Haskell
  Plug 'neovimhaskell/haskell-vim'
  Plug 'alx741/vim-stylishask'

  " Markdown
  Plug 'SidOfc/mkdx'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

  " Html
  Plug 'mattn/emmet-vim'

  " LaTeX
  Plug 'donRaphaco/neotex', { 'for': 'tex' }

  " C++
  Plug 'oblitum/rainbow', { 'for': ['cpp', 'c'], 'as': 'rainbow-cpp' }

  " Python
  Plug 'tweekmonster/braceless.vim' " TODO: learn

  " Tools
  Plug 'junegunn/vim-easy-align'
  Plug 'markonm/traces.vim'                " :substitute prewiew
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'scrooloose/nerdcommenter'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'michaeljsmith/vim-indent-object'

  " Motion
  Plug 'matze/vim-move'
  Plug 'easymotion/vim-easymotion'
  Plug 'kien/ctrlp.vim'

  " IDE
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'cohama/lexima.vim'
  Plug 'sirver/UltiSnips'
  Plug 'luochen1990/rainbow'
call plug#end()

" Mappings
" ================================================
command! Vimrc e ~/.config/nvim/init.vim

let g:move_key_modifier='C'

let g:maplocalleader=' '
let g:mapleader=' '
map \ <Plug>(easymotion-prefix)

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap <leader>sr :source %<CR>

" Tabs
" ================================================
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprevious<CR>
nnoremap <leader>ta :tabnew<CR>
nnoremap <leader>tf :tabfirst<CR>
nnoremap <leader>tl :tablast<CR>
nnoremap <leader>ts :tabs<CR>
nnoremap <leader>tq :tabclose<CR>
nnoremap <leader>to :tabonly<CR>

" Spell check
" ================================================
set spelllang=en,ru_yo
command! ToggleSpell call ToggleSpell()
function ToggleSpell()
  if(&spell)
    setlocal nospell
  else
    setlocal spell
  endif
endfunction

nnoremap <leader>st :ToggleSpell<CR>
nnoremap <leader>sp mm[s1z=`m
nnoremap <leader>sn mm]s1z=`m

autocmd FileType gitcommit,markdown,tex,text setlocal spell

" CoC
" ================================================
let g:coc_global_extensions = [
      \ "coc-git", "coc-explorer", "coc-yaml", "coc-vimlsp",
      \ "coc-texlab", "coc-python", "coc-json", "coc-rls",
      \ "coc-ultisnips", "coc-word", "coc-html"
      \ ]
function InstallCocExtensions()
  exec "CocInstall -sync " . join(g:coc_global_extensions)
endfunction

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
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

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
command! Rename normal <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>fs  <Plug>(coc-format-selected)
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

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-a)
" TODO: af, which also selects space around function

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
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"

" Emmet
" ================================================
let g:user_emmet_mode='a'
let g:user_emmet_leader_key='<C-m>'
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Terminal
" ================================================
tnoremap <Esc> <C-\><C-n>
autocmd TermOpen * setlocal nonumber norelativenumber
command! Zsh vsplit term://zsh | :startinsert

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

let g:sexp_enable_insert_mode_mappings = 0

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

" Python
" ================================================
autocmd FileType python BracelessEnable +indent

" Easy-align
" ================================================
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" Indent
" ================================================
filetype indent on
set autoindent
set expandtab
autocmd FileType *
      \ set tabstop=2
      \ | set shiftwidth=2
      \ | set softtabstop=2
autocmd FileType cpp,c,python
      \ set tabstop=4
      \ | set shiftwidth=4
      \ | set softtabstop=4

" Other settings
" ================================================
set colorcolumn=81
set splitright
set wrap
set hlsearch
set showmatch
set termencoding=utf-8
set ch=1
set title
set wildmenu
set splitbelow
set showcmd
set number
set relativenumber
set mouse=a
filetype plugin on
filetype plugin indent on

" Theme
" ================================================
set termguicolors
let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox
set background=dark
syntax on
syntax sync fromstart

" LaTeX  |latex|
" ================================================
let g:AutoPairsIgnorePrefixes = ['\', 'lr', '\left']

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
let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
                        \ 'enter': { 'shift': 1 },
                        \ 'links': { 'external': { 'enable': 1 } },
                        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                        \ }
let g:polyglot_disabled = ['markdown']
let g:mkdp_auto_close = 1

let g:mkdp_browserfunc = 'OpenMKDP'
function OpenMKDP(url)
  exec "AsyncRun qutebrowser ':open -w " . a:url . "'"
endfunction

" NERDComment
" ================================================
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" Build & Run
" ================================================
let g:buildAndRunSetup = {
      \ "c": {
        \ "build"    : "test -f '%:p:h/Makefile' && make -f '%:p:h/Makefile' || cmake '%:p:h'",
        \ "run"      : "test -f '%:p:r' && '%:p:r' || '%:p:h/main'",
        \ "needBuild": 1
        \ },
      \ "python": {
        \ "run"      : "python3 '%:p'",
        \ "needBuild": 0
        \ },
      \ "javascript": {
        \ "run"      : "node '%:p'",
        \ "needBuild": 0
        \ },
      \ "haskell": {
        \ "build"    : "stack build",
        \ "run"      : "stack test && clear && stack run",
        \ "needBuild": 0
        \ },
      \ "php": {
        \ "run"      : "php -f '%:p'",
        \ "needBuild": 0
        \ },
      \ "lisp": {
        \ "run"      : "clisp '%:p'",
        \ "needBuild": 0
        \ },
      \ "clojure": {
        \ "run":       "lein run",
        \ "needBuild": 0
        \ },
      \ "scala": {
        \ "run":       "scala '%:p'",
        \ "needBuild": 0
        \ },
      \ "rust": {
        \ "run":       "cargo run",
        \ "build":     "cargo build",
        \ "needBuild": 0
        \ },
      \ "cs": {
        \ "run":       "dotnet run",
        \ "build":     "dotnet build",
        \ "needBuild": 0
        \ },
      \ "sh": {
        \ "run":       "'%:p'",
        \ "needBuild": 0
        \ }
      \ }


function! Eq(fst, snd)
  let g:buildAndRunSetup[a:fst] = g:buildAndRunSetup[a:snd]
endfunction

call Eq("cpp", "c")

" Build
" ================================================
nnoremap <Leader>b :call Build()<CR>
command! Build execute Build()
function! Build()
  let workDir = system("pwd")
  wa | cd %:p:h
  let fileType = &ft
  if has_key(g:buildAndRunSetup, fileType)
    let setup = g:buildAndRunSetup[fileType]
    if has_key(setup, "build")
      execute "!".setup["build"]
    else
      echo fileType." has not \"build\" field"
    endif
  else
    echo "There's no \"".fileType."\" in g:buildAndRunSetup"
  endif
  execute "cd ".workDir
endfunction

" Run
" ================================================
nnoremap <Leader>r :call Run()<CR>
command! Run execute Run()
function! Run()
  let workDir = system("pwd")
  wa | cd %:p:h
  let fileType = &ft
  if has_key(g:buildAndRunSetup, fileType)
    let setup = g:buildAndRunSetup[fileType]
    if setup["needBuild"]
      execute "!".setup["build"]
    endif
    split
    execute "terminal ".setup["run"]
    startinsert
  else
    echo "There's no \"".fileType."\" in g:buildAndRunSetup"
  endif
  execute "cd ".workDir
endfunction
