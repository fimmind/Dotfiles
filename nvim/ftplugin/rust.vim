setlocal colorcolumn=101
setlocal textwidth=100

highlight link CocRustChainingHint CocCodeLens
highlight link CocRustTypeHint CocCodeLens
nmap <leader>lh :CocCommand rust-analyzer.toggleInlayHints<CR>
