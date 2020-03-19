command! -buffer Ghci vsplit term://stack ghci | :startinsert

nnoremap <buffer> <localleader>ht :call vim_hs_type#type()<CR>
