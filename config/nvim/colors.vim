let g:colors_name = ''

let s:dawn = 5
let s:dusk = 17
let s:day = 'flattened_light'
let s:night = 'flattened_dark'

" Set colorscheme based on time of day.
function! s:colorscheme() abort
  if strftime('%H') < s:dawn || strftime('%H') + 1 > s:dusk
    if g:colors_name !=# s:night
      execute 'colorscheme '.s:night
    endif
  else
    if g:colors_name !=# s:day
      execute 'colorscheme '.s:day
    endif
  endif
endfunction

" Set the colorscheme, and change it automatically as time passes.
call s:colorscheme()
autocmd vimrc CursorHold * call s:colorscheme()

if !exists('$MOSH')
  set termguicolors " Use true colors.
endif
