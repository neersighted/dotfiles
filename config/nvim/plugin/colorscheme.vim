" Reload lightline on colorscheme change.
function! s:lightline_reload()
  if !has('vim_starting')
    execute 'runtime autoload/lightline/colorscheme/'.g:lightline.colorscheme.'.vim'
    call lightline#colorscheme()
  end
endfunction

" Choose light/dark based on time of day.
function! s:timed_background()
  if strftime('%H') > 8 && strftime('%H') < 17
      set background=light
  else
      set background=dark
  endif
endfunction

let g:solarized_termcolors = 16
let g:solarized_use16 = 0
colorscheme solarized8

augroup colorscheme
  autocmd!
  autocmd VimEnter * call s:timed_background() | call s:lightline_reload()
  autocmd ColorScheme * call s:lightline_reload()
augroup END

