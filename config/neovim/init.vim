augroup vimrc " Clear autocommands.
  autocmd!
augroup end

if has('vim_starting') " Echo how long it took to start up.
  let g:startup = reltime()
  autocmd VimEnter * let ready = reltime(g:startup) | echo reltimestr(ready)
endif

runtime plugs.vim
runtime status.vim
runtime cmd.vim
runtime ft.vim
runtime maps.vim
runtime pref.vim
runtime local.vim
