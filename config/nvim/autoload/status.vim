let g:status#abbrev_width = 79 " Path abbreviation threshold.
let g:status#detail_width = 70 " Additional detail threshold.

let g:status#empty_name = '[No Name]'
let g:status#empty_ft = 'no ft'

let g:status#filetype_modes = {
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

" Helpers

function! status#is_filelike() abort
  return index(['', 'nowrite', 'acwrite'], &buftype) != -1
  " return &buftype is# '' || &buftype is# 'nowrite' || &buftype is# 'acwrite'
endfunction

function! status#has_filename() abort
  return index(['', 'help'], &buftype) != -1
  " return &buftype is# '' || &buftype is# 'help'
endfunction

function! status#show_lines() abort
  return index(['terminal', 'nofile'], &buftype) == -1
  " return &buftype isnot# 'terminal' && &buftype isnot# 'nofile'
endfunction

function! status#show_detail() abort
  return winwidth(0) > g:status#detail_width
endfunction

" Components

function! status#ale_error() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:count = l:counts.error + l:counts.style_error

  return l:count > 0
    \ ? printf('%s %d', g:ale_sign_error, l:count)
    \ : ''
endfunction

function! status#ale_warning() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:count = l:counts.total - (l:counts.error + l:counts.style_error)

  return l:count > 0
    \ ? printf('%s %d', g:ale_sign_warning, l:count)
    \ : ''
endfunction

function! status#cwd() abort
  return fnamemodify(getcwd(), ':~')
endfunction

function! status#fileencoding() abort
  return status#is_filelike() && status#show_detail()
    \ ? (!empty(&fileencoding)
      \ ? &fileencoding
      \ : &encoding)
    \ : ''
endfunction

function! status#fileformat() abort
  return status#is_filelike() && status#show_detail()
    \ ? &fileformat
    \ : ''
endfunction

function! status#fileinfo() abort
  let l:readonly = &readonly ? '!' : ''
  let l:nomodifiable = !&modifiable ? '#' : ''
  let l:modified = &modified ? '+' : ''

  if status#is_filelike()
    return status#filename() . l:readonly .  l:nomodifiable . l:modified
  else
    return status#filename()
  endif
endfunction

function! status#filename() abort
  if !status#has_filename()
    return ''
  endif

  let l:filename = (&buftype ==# 'help'
    \ ? expand('%:t')
    \ : expand('%:~:.'))
  if winwidth(0) < g:status#abbrev_width
    let l:filename = pathshorten(l:filename)
  endif

  return empty(l:filename) ? g:status#empty_name : l:filename
endfunction

function! status#filetype() abort
  return status#is_filelike() && status#show_detail()
    \ ? (!empty(&filetype)
      \ ? &filetype
      \ : g:status#empty_ft)
    \ : ''
endfunction

function status#git_head() abort
  if !exists('b:git_dir')
    return ''
  endif

  return fugitive#head()
endfunction

function! status#git_status() abort
  if !exists('b:gitgutter') || !status#show_detail()
    return ''
  endif

  let l:summary = get(b:gitgutter, 'summary', [0, 0, 0])
  return printf('+%s~%s-%s', l:summary[0], l:summary[1], l:summary[2])
endfunction

function! status#indent() abort
  return status#is_filelike() && status#show_detail()
    \ ? SleuthIndicator()
    \ : ''
endfunction

function! status#lineinfo() abort
  return status#show_lines()
    \ ? '%l:%c'
    \ : ''
endfunction

function! status#mode()
  let l:mode = get(g:status#filetype_modes, &filetype, lightline#mode())

  if &buftype ==# 'quickfix'
    let l:wininfo = getwininfo(win_getid())[0]
    let l:mode = (l:wininfo.loclist ? 'LOC' : 'QF')
  endif

  return l:mode
endfunction

function! status#paste() abort
  return &paste && status#is_filelike()
    \ ? 'PASTE'
    \ : ''
endfunction

function! status#percent() abort
  return status#show_lines()
    \ ? '%p%%'
    \ : ''
endfunction
