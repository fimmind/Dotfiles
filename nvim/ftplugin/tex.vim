nmap <buffer> <localleader>ll :NeoTexOn<CR>
nmap <buffer> <localleader>lc :NeoTex<CR>
nmap <buffer> <localleader>lo :AsyncRun zathura '%:r.pdf'<CR>

nmap <buffer> <localleader>" cs">ysi>>

" inkscape-figures
" FIXME
inoremap <buffer> <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <buffer> <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
