" *******************************************
"
"  ██▒   █▓ ██▓ ███▄ ▄███▓ ██▀███   ▄████▄
" ▓██░   █▒▓██▒▓██▒▀█▀ ██▒▓██ ▒ ██▒▒██▀ ▀█
"  ▓██  █▒░▒██▒▓██    ▓██░▓██ ░▄█ ▒▒▓█    ▄
"   ▒██ █░░░██░▒██    ▒██ ▒██▀▀█▄  ▒▓▓▄ ▄██▒
"    ▒▀█░  ░██░▒██▒   ░██▒░██▓ ▒██▒▒ ▓███▀ ░
"    ░ ▐░  ░▓  ░ ▒░   ░  ░░ ▒▓ ░▒▓░░ ░▒ ▒  ░
"    ░ ░░   ▒ ░░  ░      ░  ░▒ ░ ▒░  ░  ▒
"      ░░   ▒ ░░      ░     ░░   ░ ░
"
" *******************************************

source ~/.config/nvim/plug.vim

call plug#begin('~/.config/nvim/plugged')
  " Syntax, style
  Plug 'phaazon/gruvbox' " Not original, couse of haskell-vim support
  Plug 'suy/vim-qmake'
  Plug 'justinmk/vim-syntax-extra'
  Plug 'PotatoesMaster/i3-vim-syntax'

  " Haskell
  Plug 'neovimhaskell/haskell-vim'
  Plug 'jaspervdj/stylish-haskell'
  Plug 'Chiel92/vim-autoformat'

  " Markdown
  Plug 'SidOfc/mkdx'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

  " NERDTree
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'jistr/vim-nerdtree-tabs'

  " Tools
  Plug 'airblade/vim-gitgutter'
  Plug 'junegunn/vim-easy-align'
  Plug 'markonm/traces.vim'
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'tpope/vim-surround'

  " Frontend
  Plug 'mattn/emmet-vim'

  " Motion
  Plug 'matze/vim-move'
  Plug 'easymotion/vim-easymotion'
  Plug 'kien/ctrlp.vim'
  Plug 'vim-scripts/a.vim'

  " Format code
  Plug 'google/vim-maktaba'
  Plug 'google/vim-codefmt'
  Plug 'google/vim-glaive'

  " Autocompletion
  Plug 'cohama/lexima.vim'
  Plug 'lervag/vimtex'
  Plug 'vim-scripts/vim-auto-save'
  Plug 'deoplete-plugins/deoplete-jedi'
  Plug 'SirVer/ultisnips'

  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()

" Mappings
" ================================================
command! Vimrc e ~/.config/nvim/init.vim

" Deoplete
" ================================================
let g:deoplete#enable_at_startup = 1

call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

" Selction of indent block
" ================================================
function SelectIndent()
  let cur_line = line(".")
  let cur_ind = indent(cur_line)
  let line = cur_line
  while indent(line - 1) >= cur_ind
    let line = line - 1
  endw
  exe "normal " . line . "G"
  exe "normal V"
  let line = cur_line
  while indent(line + 1) >= cur_ind
    let line = line + 1
  endw
  exe "normal " . line . "G"
endfunction
nnoremap vii :call SelectIndent()<CR>

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
let g:user_emmet_leader_key='<C-e>'

" Terminal
" ================================================
tnoremap <Esc> <C-\><C-n>
autocmd TermOpen * setlocal nonumber norelativenumber

" Haskell
" ================================================
let g:haskell_indent_if = 2
let g:haskell_indent_case = 2
let g:haskell_indent_let = 4
let g:haskell_indent_where = 6
let g:haskell_indent_before_where = 2
let g:haskell_indent_after_bare_where = 2
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

command! Ghci vsplit term://stack ghci | :startinsert

autocmd BufWrite *.hs :Autoformat
" Don't automatically indent on save, since vim's autoindent for haskell is buggy
autocmd FileType haskell let b:autoformat_autoindent=0

" Easy-align
" ================================================
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" Indent
" ================================================
filetype indent on
set autoindent
set expandtab
autocmd! FileType *
      \ set tabstop=2
      \ | set shiftwidth=2
      \ | set softtabstop=2
autocmd! FileType cpp,c
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
set nobackup
set showcmd
set number
set relativenumber
set mouse=a
set conceallevel=0
filetype plugin on
filetype plugin indent on

" Theme
" ================================================
set termguicolors
colorscheme gruvbox
set background=dark
syntax on

" LaTeX
" ================================================
let g:tex_flavor='latex'
let g:Tex_GotoError = 0
let g:vimtex_view_method = 'zathura'
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

call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'latex'})
call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'latex'})
call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'latex'})

call lexima#add_rule({'char': '<Space>', 'at': '\$\%#\$', 'input_after': '<Space>', 'filetype': 'latex'})

" Markdown
" ================================================
let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
                        \ 'enter': { 'shift': 1 },
                        \ 'links': { 'external': { 'enable': 1 } },
                        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                        \ }
let g:polyglot_disabled = ['markdown']

let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1

let g:mkdp_browser = "qutebrowser"

" Mappings
" ================================================
let g:move_key_modifier='S'

let g:mapleader=','
map \ <Plug>(easymotion-prefix)

" NERDTree
" ================================================
command! CloseTree :NERDTreeClose
noremap <C-\> :NERDTreeToggle<CR>
inoremap <C-\> <Esc>:NERDTreeToggle<CR>a
command! -nargs=1 Where :NERDTreeFind <args>

" let g:NERDTreeIndicatorMapCustom = {
" \ "Modified"  : "✹",
" \ "Staged"    : "✚",
" \ "Untracked" : "✭",
" \ "Renamed"   : "➜",
" \ "Unmerged"  : "═",
" \ "Deleted"   : "✖",
" \ "Dirty"     : "✗",
" \ "Clean"     : "✔︎",
" \ "Ignored"   : "☒",
" \ "Unknown"   : "?"
" \ }

" Build & Run
" ================================================
let g:buildAndRunSetup = {
      \ "c": {
      \   "build"    : "test -f '%:p:h/Makefile' && make -f '%:p:h/Makefile' || cmake '%:p:h'",
      \   "run"      : "test -f '%:p:r' && '%:p:r' || '%:p:h/main'",
      \   "needBuild": 1
      \   },
      \ "py": {
      \   "run"      : "python3 '%:p'",
      \   "needBuild": 0
      \   },
      \ "js": {
      \   "run"      : "node '%:p'",
      \   "needBuild": 0
      \   },
      \ "hs": {
      \   "build"    : "stack build",
      \   "run"      : "stack test && clear && stack run",
      \   "needBuild": 0
      \   },
      \ "php": {
      \   "run"      : "php -f '%:p'",
      \   "needBuild": 0
      \   },
      \ "lisp": {
      \   "run"      : "clisp '%:p'",
      \   "needBuild": 0
      \ }
      \ }


function! Eq(fst, snd)
  let g:buildAndRunSetup[a:fst] = g:buildAndRunSetup[a:snd]
endfunction

call Eq("h",   "c" )
call Eq("cpp", "c" )
call Eq("hpp", "c" )

" Build
" ================================================
nnoremap <Leader>b :call Build()<CR>
command! Build execute Build()
function! Build()
  let workDir = system("pwd")
  wa | cd %:p:h
  let fileType = expand("%:e")
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
nnoremap <Leader>e :call Run()<CR>
command! Run execute Run()
function! Run()
  let workDir = system("pwd")
  wa | cd %:p:h
  let fileType = expand("%:e")
  if has_key(g:buildAndRunSetup, fileType)
    let setup = g:buildAndRunSetup[fileType]
    if setup["needBuild"]
      execute "!".setup["build"]
    endif
    execute ":split term://".setup["run"]." | :startinsert"
  else
    echo "There's no \"".fileType."\" in g:buildAndRunSetup"
  endif
  execute "cd ".workDir
endfunction

command! Hugsrun w | !clear && termux-chroot runhugs '%:p'
