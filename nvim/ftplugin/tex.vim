if has("android")
  nnoremap <buffer><silent> <leader>m :!pdflatex %<cr>
  nnoremap <buffer><silent> <leader>b :!pdflatex %<cr>

  nnoremap <buffer><silent> <leader>r :silent !
        \ dir=~/storage/downloads/Tex_Preview;
        \ mkdir -p $dir;
        \ f=$dir/Compilation_Result.pdf;
        \ cp %:p:r.pdf $f;
        \ termux-open $f<cr>
endif
