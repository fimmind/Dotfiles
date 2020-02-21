command! -buffer ReplTab tabnew term://lein repl | startinsert
nnoremap <buffer> <localleader>tr :ReplTab<CR>
