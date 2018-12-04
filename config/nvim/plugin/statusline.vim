" Hook into other plugins to update the statusline.
augroup lightline_hook
  autocmd!
  autocmd User ALELintPost call lightline#update()
  autocmd User Fugitive call lightline#update()
  autocmd User GitGutter call lightline#update()
augroup END

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'mode_map': {
  \   'n': 'N', 'i': 'I', 'R': 'R', 'v': 'V', 'V': '-V-', "\<C-v>": '[V]',
  \   'c': ':', 's': 'S', 'S': '-S-', "\<C-s>": '[S]', 't': '$'
  \ },
  \ 'active': {
  \     'left': [
  \       [ 'mode', 'paste' ],
  \       [ 'fileinfo' ],
  \       [ 'git_status' ],
  \     ],
  \     'right': [
  \       [ 'ale_error', 'ale_warning', 'lineinfo' ],
  \       [ 'percent' ],
  \       [ 'indent', 'fileformat', 'fileencoding', 'filetype' ],
  \     ],
  \   },
  \   'inactive': {
  \     'left': [
  \       [ 'filename' ],
  \     ],
  \     'right': [
  \       [],
  \       [ 'lineinfo', 'percent' ],
  \     ],
  \   },
  \   'tabline': {
  \     'left': [
  \       [ 'tabs' ],
  \     ],
  \     'right': [
  \       [ 'cwd' ],
  \       [ 'git_head' ],
  \     ],
  \   },
  \   'component': {},
  \   'component_function': {
  \     'fileencoding': 'status#fileencoding',
  \     'fileformat':   'status#fileformat',
  \     'fileinfo':     'status#fileinfo',
  \     'filename':     'status#filename',
  \     'filetype':     'status#filetype',
  \     'indent':       'status#indent',
  \     'mode':         'status#mode',
  \     'paste':        'status#paste',
  \   },
  \   'component_function_visible_condition': {
  \     'fileencoding': 'status#is_filelike() && status#show_detail()',
  \     'fileformat':   'status#is_filelike() && status#show_detail()',
  \     'fileinfo':     'status#has_filename() && status#is_filelike()',
  \     'filename':     'status#has_filename()',
  \     'filetype':     'status#is_filelike() && status#show_detail()',
  \     'indent':       'status#is_filelike() && status#show_detail()',
  \     'paste':        '&paste && status#is_filelike()',
  \     'mode':         1,
  \   },
  \   'component_expand': {
  \     'ale_error':   'status#ale_error',
  \     'ale_warning': 'status#ale_warning',
  \     'cwd':         'status#cwd',
  \     'git_head':    'status#git_head',
  \     'git_status':  'status#git_status',
  \     'lineinfo':    'status#lineinfo',
  \     'percent':     'status#percent',
  \   },
  \   'component_type': {
  \     'ale_error':   'error',
  \     'ale_warning': 'warning',
  \   },
  \ }

" Use lightline in Tagbar.
function! TagbarStatusline(current, sort, fname, ...) abort
  return lightline#statusline(0)
endfunction
let g:tagbar_status_func = 'TagbarStatusline'
