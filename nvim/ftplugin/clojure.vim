command! -buffer ReplTab tabnew term://iced repl
command! -buffer Repl vsplit term://iced repl

" This overrides CoC's mappings
nnoremap <buffer> <leader>fs :IcedFormat<CR>
nnoremap <buffer> <leader>ff :IcedFormatAll<CR>
