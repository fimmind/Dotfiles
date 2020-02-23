command! -buffer Ghci vsplit term://stack ghci | :startinsert

command! -buffer HsType
        \ :exec ":w | :!hdevtools type -s .hdevtools.sock"
        \ . " % "
        \ . line(".") . " "
        \ . col(".")

nnoremap <buffer> <localleader>ht :HsType<CR>

