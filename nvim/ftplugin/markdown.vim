nnoremap <buffer> <leader>ml :MarkdownPreview<CR>

nnoremap <buffer> <localleader>lc :!pandoc % -o %:r.pdf<CR>
nnoremap <buffer> <localleader>lo :AsyncRun zathura %:r.pdf<CR>
