setlocal colorcolumn=101
setlocal textwidth=100

highlight link CocRustChainingHint CocCodeLens
highlight link CocRustTypeHint CocCodeLens
nmap <localleader>h :CocCommand rust-analyzer.toggleInlayHints<CR>

nnoremap <silent><buffer> <leader>m :!cargo build<cr>
nnoremap <silent><buffer> <leader>b :vsplit term://cargo build<cr>
nnoremap <silent><buffer> <leader>r :vsplit term://cargo run<cr>
