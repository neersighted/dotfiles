" Enable rainbow by default.
let g:rainbow_active = 1

" Recycle colors from the current colorscheme.
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

