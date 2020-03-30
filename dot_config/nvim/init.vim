" Display start-up time.
let s:start_time = reltime()
augroup startup
  autocmd!
  autocmd VimEnter * if !empty(nvim_list_uis()) | echo reltimestr(reltime(s:start_time)) | endif
augroup end

" Disable Python 2 support.
let g:loaded_python_provider = 0
" Use correct Python 3 virtual environment.
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim/bin/python'

" Open commits in a split.
let $GIT_EDITOR = 'nvr --remote-wait -cc split'
