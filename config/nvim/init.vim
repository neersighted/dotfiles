augroup vimrc " Clear autocommands.
  autocmd!
augroup end

if !v:vim_did_enter " Echo how long it took to start up.
  let s:startup = reltime()
  autocmd vimrc VimEnter * let s:ready = reltime(s:startup) | echo reltimestr(s:ready)
endif

runtime ft.vim
runtime cmd.vim
runtime maps.vim
runtime prefs.vim
runtime complete.vim
runtime colors.vim
runtime status.vim
runtime packs.vim
runtime local.vim
