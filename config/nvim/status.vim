" Lightline Configuration

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
      \     ],
      \     'right': [
      \       [ 'ale', 'lineinfo' ],
      \       [ 'percent' ],
      \       [ 'fileformat', 'fileencoding', 'filetype' ],
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
      \       [ 'fugitive' ],
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
      \     'fugitive':     'fugitive#head',
      \     'mode':         'status#mode',
      \     'paste':        'status#paste',
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

" Helpers

function! s:is_filelike() abort
  return &buftype ==# '' || &buftype =~# '^nowrite\|acwrite$'
endfunction

function! s:has_filename() abort
  return &buftype ==# '' || &buftype ==# 'help'
endfunction

function! s:show_lines() abort
  return &buftype !~# '^terminal\|nofile'
endfunction

let s:filetype_modes = {
      \ 'startify': 'STARTIFY',
      \ 'MundoDiff': 'UNDODIFF',
      \ 'Mundo': 'UNDO',
      \ 'fugitiveblame': 'BLAME',
      \ 'dirvish': 'DIR',
      \ 'fzf': 'FZF',
      \ 'help': 'HELP',
      \ 'man': 'MAN',
      \ }

" Components
"
function! status#ale() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '' : printf(
  \   'W:%d E:%d',
  \   l:all_non_errors,
  \   l:all_errors
  \)
endfunction

function! status#cwd() abort
  return fnamemodify(getcwd(), ':~')
endfunction

function! status#fileencoding() abort
  return s:is_filelike() && winwidth(0) > 70
        \ ? (!empty(&fileencoding)
          \ ? &fileencoding
          \ : &encoding)
        \ : ''
endfunction

function! status#fileformat() abort
  return s:is_filelike() && winwidth(0) > 70
        \ ? &fileformat
        \ : ''
endfunction

function! status#fileinfo() abort
  let l:filelike = s:is_filelike()

  let l:readonly = (&readonly && l:filelike ? '!' : '')
  let l:nomodifiable = (!&modifiable && l:filelike ? '#' : '')
  let l:modified = (&modified && l:filelike ? '+' : '')

  return status#filename() . l:readonly .  l:nomodifiable . l:modified
endfunction

function! status#filename() abort
  if !s:has_filename()
    return ''
  endif

  let l:filename = (&buftype ==# 'help'
        \ ? expand('%:t')
        \ : expand('%:~:.'))
  if winwidth(0) < 79
    let l:filename = pathshorten(l:filename)
  endif

  return empty(l:filename) ? '[No Name]' : l:filename
endfunction

function! status#filetype() abort
  return s:is_filelike() && winwidth(0) > 70
        \ ? (!empty(&filetype)
          \ ? &filetype
          \ : 'no ft')
        \ : ''
endfunction

function! status#lineinfo() abort
  return s:show_lines()
        \ ? '%l:%c'
        \ : ''
endfunction

function! status#mode()
  let l:mode = get(s:filetype_modes, &filetype, lightline#mode())

  if &buftype ==# 'quickfix'
    let l:wininfo = getwininfo(win_getid())[0]
    let l:mode = (l:wininfo.loclist ? 'LOC' : 'QF')
  endif

  return winwidth(0) > 40
        \ ? l:mode
        \ : ''
endfunction

function! status#paste() abort
  return &paste && s:is_filelike()
        \ ? 'PASTE'
        \ : ''
endfunction

function! status#percent() abort
  return s:show_lines()
        \ ? '%p%%'
        \ : ''
endfunction

