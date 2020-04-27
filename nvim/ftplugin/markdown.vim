nnoremap <buffer> <localleader>ml :MarkdownPreview<CR>

nnoremap <buffer> <localleader>lc :w<CR>:!pandoc % -o %:r.pdf<CR>
nnoremap <buffer> <localleader>lo :AsyncRun zathura %:r.pdf<CR>

nnoremap <buffer> <localleader>fs vapgq


UltiSnipsAddFiletypes markdown,tex
