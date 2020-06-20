setlocal colorcolumn=101
setlocal textwidth=100

nnoremap <buffer> <localleader>rt :split term://cargo test<CR>
nnoremap <buffer> <localleader>ae :CocCommand rust-analyzer.expandMacro<CR>
