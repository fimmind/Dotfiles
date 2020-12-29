if exists('g:build_and_run_autoload') && g:build_and_run_autoload
  finish
endif
let g:build_and_run_autoload = 1

" Messaging
" ================================================
function! s:build_message(msg)
  return ":echo \"build-and-run: " . a:msg . "\""
endfunction

function! s:print_message(msg)
  exec s:build_message(a:msg)
endfunction

" Read configuration
" ================================================
let s:config = {
      \ "save_on_build": 1,
      \ "save_on_run": 1
      \ }

if exists("g:build_and_run_config")
  for [key, val] in items(g:build_and_run_config)
    if has_key(s:config, key)
      let s:config[key] = val
    else
      call s:print_message("Ignoring unknown option '" . key . "' in config")
    endif
  endfor
endif

" Commands evaluation
" ================================================
function! s:run_cmd(cmd)
  if empty(a:cmd)
    return
  endif

  if a:cmd[0] == "!" || a:cmd[0] == ":"
    exec a:cmd
  else
    split
    exec "term" a:cmd
    startinsert
  endif
endfunction

" Saving working directory
" ================================================
function! s:save_cwd()
  if !exists("s:working_dir")
    let s:working_dir = getcwd()
  endif
endfunction

function! s:restore_cwd()
  exe "cd" s:working_dir
  unlet s:working_dir
endfunction

" Input
" ================================================
function! s:input_saved(prompt, var_name)
    redraw!
    if !exists(a:var_name)
      exec "let ".a:var_name." = ''"
    endif
    exec "let ".a:var_name." = input('".a:prompt.": ', ".a:var_name.")"
    redraw!
    exec "return ".a:var_name
endfunction

" Build
" ================================================
function! build_and_run#build()
  if s:config["save_on_build"]
    wa
  endif

  call s:save_cwd()
  call s:run_cmd(s:input_saved("Build",  "b:bnr_build_command"))
  call s:restore_cwd()
endfunction

" Run
" ================================================
function! build_and_run#run()
  if s:config["save_on_run"]
    wa
  endif

  call s:save_cwd()
  call s:run_cmd(s:input_saved("Run", "b:bnr_run_command"))
  call s:restore_cwd()
endfunction
