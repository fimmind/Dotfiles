setlocal colorcolumn=101
setlocal textwidth=100

highlight link CocRustChainingHint CocCodeLens
highlight link CocRustTypeHint CocCodeLens
nmap <localleader>h :CocCommand rust-analyzer.toggleInlayHints<CR>
