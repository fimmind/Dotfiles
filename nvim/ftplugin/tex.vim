nmap <buffer> <leader>ll :NeoTexOn<CR>
nmap <buffer> <leader>lc :NeoTex<CR>
nmap <buffer> <leader>lo :AsyncRun zathura '%:r.pdf'<CR>

nmap <buffer> <leader>" cs">ysi>>

" inkscape-figures
" FIXME
inoremap <buffer> <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <buffer> <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
