command! -buffer ReplTab tabnew term://lein repl
command! -buffer Repl vsplit term://lein repl

imap <buffer> " <Plug>(sexp_insert_double_quote)
imap <buffer> <BS> <Plug>(sexp_insert_backspace)

nnoremap <buffer> <leader>K :ConjureDoc<Space>

nnoremap <buffer> <localleader>rm :Run<CR>
