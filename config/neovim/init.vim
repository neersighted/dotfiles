if has('vim_starting') " Echo how long it took to start up.
  let startup = reltime()
  autocmd VimEnter * let ready = reltime(startup) | redraw | echo reltimestr(ready)
endif

augroup vimrc
autocmd!

runtime plugs.vim
runtime ui.vim
runtime cmd.vim
runtime maps.vim

augroup end
