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

" Getting access to g:build_and_run_setup
" ================================================
function! s:is_ft_configured()
  return has_key(g:build_and_run_setup, &ft)
endfunction

function! s:get_setup_key(key, default)
  let l:setup = g:build_and_run_setup[&ft]
  if !has_key(setup, a:key)
    return a:default
  endif

  return l:setup[a:key]
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

" Build
" ================================================
function! s:build_bare()
  call s:run_cmd(s:get_setup_key("build", s:build_message("There's no 'build' field for " . &ft)))
endfunction

function! build_and_run#build()
  if !s:is_ft_configured()
    call s:print_message("filetype " . &ft . " is not configured")
    return
  endif

  call s:save_cwd()
  call s:build_bare()
  call s:restore_cwd()
endfunction

" Run
" ================================================
function! s:run_bare()
  call s:run_cmd(s:get_setup_key("run", s:build_message("There's no 'run' field for " . &ft)))
endfunction

function! build_and_run#run()
  if !s:is_ft_configured()
    call s:print_message("filetype " . &ft . " is not configured")
    return
  endif

  call s:save_cwd()

  if s:get_setup_key("need_build", 0)
    call s:build_bare()
  endif
  call s:run_bare()

  call s:restore_cwd()
endfunction
