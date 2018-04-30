autocmd User ALELint call lightline#update() " Update status bar on lint.

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '|', 'right': '|' },
  \ 'mode_map': {
  \   'n': 'N', 'i': 'I', 'R': 'R', 'v': 'V', 'V': '-V-', "\<C-v>": '[V]',
  \   'c': ':', 's': 'S', 'S': '-S-', "\<C-s>": '[S]', 't': '$'
  \ },
  \ 'active': {
  \     'left': [
  \       [ 'mode', 'paste' ],
  \       [ 'fileinfo' ],
  \       [ 'tag' ],
  \     ],
  \     'right': [
  \       [ 'ale', 'lineinfo' ],
  \       [ 'percent' ],
  \       [ 'indent', 'fileformat', 'fileencoding', 'filetype' ],
  \     ],
  \   },
  \   'inactive': {
  \     'left': [
  \       [ 'filename' ],
  \     ],
  \     'right': [
  \       [ 'percent' ],
  \     ],
  \   },
  \   'tabline': {
  \     'left': [
  \       [ 'tabs' ],
  \     ],
  \     'right': [
  \       [ 'cwd' ],
  \       [ 'git' ],
  \     ],
  \   },
  \   'component': {},
  \   'component_function': {
  \     'cwd':          'status#cwd',
  \     'fileencoding': 'status#fileencoding',
  \     'fileformat':   'status#fileformat',
  \     'fileinfo':     'status#fileinfo',
  \     'filename':     'status#filename',
  \     'filetype':     'status#filetype',
  \     'git':          'fugitive#head',
  \     'indent':       'status#indent',
  \     'mode':         'status#mode',
  \     'paste':        'status#paste',
  \     'tag':          'status#tag',
  \   },
  \   'component_expand': {
  \     'ale':      'status#ale',
  \     'lineinfo': 'status#lineinfo',
  \     'percent':  'status#percent',
  \   },
  \   'component_type': {
  \     'ale': 'error',
  \   },
  \ }
