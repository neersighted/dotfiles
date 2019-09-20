" Display start-up time.
let s:start_time = reltime()
augroup startup
  autocmd!
  autocmd VimEnter * echo reltimestr(reltime(s:start_time))
augroup end

" Use the proper virtual environments for python support.
let g:python_host_prog = $PYENV_ROOT . '/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'

" Open commits in a split.
let $GIT_EDITOR = 'nvr --remote-wait -cc split'
