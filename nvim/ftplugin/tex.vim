if has("android")
  nnoremap <buffer><silent> <leader>b :w<cr>:!latexmk -pdf -cd -silent %<cr>

  nnoremap <buffer><silent> <leader>r :w<cr>:silent !
        \ dir=~/storage/downloads/Tex_Preview;
        \ mkdir -p $dir;
        \ f=$dir/Compilation_Result.pdf;
        \ cp %:p:r.pdf $f;
        \ termux-open $f<cr>

  nnoremap <buffer><silent> <leader>m :w<cr>:!
        \ latexmk -pdf -cd % \|\| exit;
        \ dir=~/storage/downloads/Tex_Preview;
        \ mkdir -p $dir;
        \ f=$dir/Compilation_Result.pdf;
        \ cp %:p:r.pdf $f;
        \ termux-open $f<cr>
endif
