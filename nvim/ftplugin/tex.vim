if has("android")
  nnoremap <buffer><silent> <leader>b :w<cr>:!latexmk -pdf -cd -silent %<cr>

  nnoremap <buffer><silent> <leader>r :w<cr>:silent !
        \ xdg-open "%:p:r.pdf"<cr>

  nnoremap <buffer><silent> <leader>m :w<cr>:!
        \ latexmk -pdf -cd % \|\| exit;
        \ xdg-open "%:p:r.pdf"<cr>
endif
