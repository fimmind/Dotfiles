command! -buffer ReplTab tabnew term://lein repl
nnoremap <buffer> <localleader>tr :ReplTab<CR>:tabprevious<CR>

imap <buffer> " <Plug>(sexp_insert_double_quote)
imap <buffer> <BS> <Plug>(sexp_insert_backspace)
