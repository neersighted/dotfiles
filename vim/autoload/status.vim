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
  \ 'Mundo': 'UNDO',
  \ 'MundoDiff': 'UNDODIFF',
  \ 'dirvish': 'DIR',
  \ 'fugitiveblame': 'BLAME',
  \ 'fzf': 'FZF',
  \ 'help': 'HELP',
  \ 'man': 'MAN',
  \ 'startify': 'STARTIFY',
  \ 'tagbar': 'TAGS',
  \ }

" Components

function! status#ale() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '' : printf(
    \ 'W:%d E:%d',
    \ l:all_non_errors,
    \ l:all_errors
    \)
endfunction

function! status#cwd() abort
  return fnamemodify(., ':~')
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

function! status#git() abort
  return s:is_filelike() && winwidth(0) > 70
    \ ? fugitive#head()
    \ : ''
endfunction

function! status#indent() abort
  return s:is_filelike() && winwidth(0) > 70
    \ ? SleuthIndicator()
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
