nnoremap <buffer> <leader>ml :MarkdownPreview<CR>

nnoremap <buffer> <localleader>lc :w<CR>:!pandoc % -o %:r.pdf<CR>
nnoremap <buffer> <localleader>lo :AsyncRun zathura %:r.pdf<CR>
