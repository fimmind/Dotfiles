nmap <buffer> <localleader>ll :NeoTexOn<CR>
nmap <buffer> <localleader>lc :NeoTex<CR>
nmap <buffer> <localleader>lo :AsyncRun zathura '%:p:r.pdf'<CR>

nmap <buffer> <localleader>" cs">ysi>>

" inkscape-figures
inoremap <buffer> <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.projectroot#guess().'/figures/"'<CR><CR>:w<CR>
nnoremap <buffer> <C-f> : silent exec '!inkscape-figures edit "'.projectroot#guess().'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
