let g:colors_name = ''

let s:dawn = 5
let s:dusk = 17
let s:day = 'flattened_light'
let s:night = 'flattened_dark'

" Set colorscheme based on time of day.
function! s:colorscheme() abort
  if strftime('%H') < s:dawn || strftime('%H') + 1 > s:dusk
    if g:colors_name !=# s:night
      let l:newscheme = s:night
    endif
  else
    if g:colors_name !=# s:day
      let l:newscheme = s:day
    endif
  endif

  if exists('l:newscheme')
    execute 'colorscheme' l:newscheme

    " Cleanup to make the change stick.
    let &syntax = &syntax
    silent! call lightline#colorscheme()
  endif
endfunction

" Set the colorscheme, and change it automatically as time passes.
call s:colorscheme()
autocmd vimrc CursorHold * call s:colorscheme()

if !exists('$MOSH')
  set termguicolors " Use true colors.
endif
