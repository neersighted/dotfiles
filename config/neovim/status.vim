scriptencoding utf-8

" Lightline Configuration

let g:lightline = {
  \ 'colorscheme': 'flattened_light',
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
  \       [ 'branch' ],
  \       [ 'gstatus', 'gtraffic' ],
  \     ],
  \   },
  \   'component': {},
  \   'component_function': {},
  \   'component_expand': {},
  \   'component_type': {},
  \ }

" Helpers

function! s:is_filelike() abort
  return &buftype ==# '' || &buftype =~# '^nowrite\|acwrite$'
endfunction

function! s:has_lines() abort
  return &buftype !=# 'terminal'
endfunction

" Components

let g:lightline.component_function.mode = 'status#mode'
function! status#mode()
  return &buftype ==# 'quickfix' ? 'QF' :
    \ &filetype ==# 'help' ? 'HELP' :
    \ &filetype ==# 'startify' ? 'START' :
    \ &filetype ==# 'fzf' ? 'FZF' :
    \ &filetype ==# 'gita-status' ? 'GITA' :
    \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:lightline.component_function.paste = 'status#paste'
function! status#paste() abort
  return &paste && s:is_filelike()
    \ ? 'PASTE'
    \ : ''
endfunction

let g:lightline.component_function.fileinfo = 'status#fileinfo'
function! status#fileinfo() abort
  let l:readonly = status#readonly()
  let l:filename = status#filename()
  let l:nomodifiable = status#nomodifiable()
  let l:modified = status#modified()

  return '' .
    \ (empty(l:readonly) ? '' : l:readonly . ' ') .
    \ (empty(l:filename) ? '' : l:filename) .
    \ (empty(l:nomodifiable) ? '' : ' ' . l:nomodifiable) .
    \ (empty(l:modified) ? '' : ' ' . l:modified)
endfunction

let g:lightline.component_function.readonly = 'status#readonly'
function! status#readonly() abort
  return &readonly && s:is_filelike()
    \ ? ''
    \ : ''
endfunction

let g:lightline.component_function.filename = 'status#filename'
function! status#filename() abort
  if !s:is_filelike()
    return ''
  endif

  let l:filename = winwidth(0) > 79
    \ ? expand('%:~:.')
    \ : pathshorten(expand('%:~:.'))

  return empty(l:filename) ? '[No Name]' : l:filename
endfunction

let g:lightline.component_function.modified = 'status#modified'
function! status#modified() abort
  return &modified && s:is_filelike()
    \ ? '+'
    \ : ''
endfunction

let g:lightline.component_function.nomodifiable = 'status#nomodifiable'
function! status#nomodifiable() abort
  return !&modifiable && s:is_filelike()
    \ ? '#'
    \ : ''
endfunction

let g:lightline.component_function.fileformat = 'status#fileformat'
function! status#fileformat() abort
  return s:is_filelike() && winwidth(0) > 70 ? &fileformat : ''
endfunction

let g:lightline.component_function.fileencoding = 'status#fileencoding'
function! status#fileencoding() abort
  return s:is_filelike() && winwidth(0) > 70
    \ ? (!empty(&fileencoding)
      \ ? &fileencoding
      \ : &encoding)
    \ : ''
endfunction

let g:lightline.component_function.filetype = 'status#filetype'
function! status#filetype() abort
  return s:is_filelike() && winwidth(0) > 70
    \ ? (!empty(&filetype)
      \ ? &filetype
      \ : 'no ft')
    \ : ''
endfunction

let g:lightline.component_expand.percent = 'status#percent'
function! status#percent() abort
  return s:has_lines()
    \ ? '%p%%'
    \ : ''
endfunction

let g:lightline.component_expand.lineinfo = 'status#lineinfo'
function! status#lineinfo() abort
  return s:has_lines()
    \ ? '%l:%c'
    \ : ''
endfunction

let g:lightline.component_type.ale = 'error'
let g:lightline.component_expand.ale = 'status#ale'
function! status#ale() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '' : printf(
    \   'W:%d E:%d',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

let g:lightline.component_function.cwd = 'status#cwd'
function! status#cwd() abort
  return fnamemodify(getcwd(), ':~')
endfunction

let g:lightline.component_function.branch = 'status#branch'
function! status#branch() abort
  return exists('*gita#statusline#format')
    \ ? gita#statusline#format('%{|/}ln%lb%{ ⇄  |}rn%{/|}rb')
    \ : ''
endfunction

let g:lightline.component_function.gstatus = 'status#gstatus'
function! status#gstatus() abort
  return exists('*gita#statusline#format')
    \ ? gita#statusline#format('%{!| }nc%{+| }na%{-| }nd%{"| }nr%{*| }nm%{@|}nu')
    \ : ''
endfunction

let g:lightline.component_function.gtraffic = 'status#gtraffic'
function! status#gtraffic() abort
  return exists('*gita#statusline#format')
    \ ? gita#statusline#format('%{↓| }ic%{↑|}og')
    \ : ''
endfunction

