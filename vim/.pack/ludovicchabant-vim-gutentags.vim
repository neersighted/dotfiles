let s:uname = system('uname')
if s:uname =~# 'FreeBSD'
  if executable('uctags')
    let g:gutentags_ctags_executable = 'uctags'
  elseif executable('exctags')
    let g:gutentags_ctags_executable = 'exctags'
  endif
endif
