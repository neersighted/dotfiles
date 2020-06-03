"
" All
"

let g:rainbow_active = 1 " Enable rainbow pairs.
function! s:rainbow_reload()
  if !exists('g:terminal_color_1')
    return
  end

  let g:rainbow_conf = {
        \   'guifgs': [
        \     g:terminal_color_4,
        \     g:terminal_color_3,
        \     g:terminal_color_5,
        \     g:terminal_color_6,
        \     g:terminal_color_2,
        \   ]
        \ }
endfunction
augroup rainbow_reload
  autocmd ColorScheme * call s:rainbow_reload()
augroup END

let g:carbon_now_sh_options = {
      \ 't': g:colors_name,
      \ 'fm': 'Source Code Pro',
      \ }

"
" Go
"

let g:go_highlight_build_constraints = 1

"
" Python
"

let g:python_highlight_all = 1
