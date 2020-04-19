command! -buffer ReplTab tabnew term://iced repl
command! -buffer Repl vsplit term://iced repl

augroup IcedDocumentClose " TODO: open an issue
  autocmd InsertEnter  <buffer> IcedDocumentClose
  autocmd TextChanged  <buffer> IcedDocumentClose
  autocmd TextChangedI <buffer> IcedDocumentClose
  autocmd TextChangedP <buffer> IcedDocumentClose
  autocmd BufLeave     <buffer> IcedDocumentClose
  autocmd WinLeave     <buffer> IcedDocumentClose
  autocmd WinNew       <buffer> IcedDocumentClose
augroup END

" This overrides CoC's mappings
nnoremap <buffer> <leader>fs :IcedFormat<CR>
nnoremap <buffer> <leader>ff :IcedFormatAll<CR>
