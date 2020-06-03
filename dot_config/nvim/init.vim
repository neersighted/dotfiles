" Display start-up time.
let s:start_time = reltime()
augroup startup
  autocmd!
  autocmd VimEnter * if !empty(nvim_list_uis()) | echo reltimestr(reltime(s:start_time)) | endif
augroup end

" Load all config files.
runtime! init.d/*.vim
