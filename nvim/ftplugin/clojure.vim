command! -buffer ReplTab tabnew term://iced repl
command! -buffer Repl vsplit term://iced repl

imap <buffer> " <Plug>(sexp_insert_double_quote)
imap <buffer> <BS> <Plug>(sexp_insert_backspace)

nnoremap <buffer> <localleader>rr :Run<CR>

" This overrides CoC's mappings
nnoremap <buffer> <leader>fs :IcedFormat<CR>
nnoremap <buffer> <leader>ff :IcedFormatAll<CR>
