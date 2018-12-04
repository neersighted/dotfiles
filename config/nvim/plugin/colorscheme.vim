" Reload lightline on colorscheme change.
augroup lightline_reload
  autocmd!
  autocmd ColorScheme * if !has('vim_starting')
        \ | execute 'runtime autoload/lightline/colorscheme/'.g:lightline.colorscheme.'.vim'
        \ | call lightline#colorscheme()
        \ | end
augroup END

" Choose light/dark based on time of day.
if strftime('%H') > 8 && strftime('%H') < 17
    set background=light
else
    set background=dark
endif

" Use 16 colors when true color is not supported.
let g:solarized_use16 = 1
let g:solarized_termcolors = 16

" Load the colorscheme.
colorscheme solarized8
