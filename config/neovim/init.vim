augroup vimrc " Clear autocommands.
  autocmd!
augroup end

if has('vim_starting') " Echo how long it took to start up.
  let g:startup = reltime()
  autocmd VimEnter * let ready = reltime(g:startup) | redraw | echo reltimestr(ready)
endif

runtime plugs.vim
runtime ui.vim
runtime cmd.vim
runtime ft.vim
runtime maps.vim
runtime local.vim
