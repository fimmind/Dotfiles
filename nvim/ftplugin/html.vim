nnoremap <buffer> <localleader>ll :call <SID>startBrowserSync()<CR>
function! s:startBrowserSync()
  tabnew term://browser-sync start --server --files './*' --browser chromium
endfunction
