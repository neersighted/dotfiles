if $TERM !=# "xterm" && $TERM !=# "linux"
  set termguicolors " Use true color in non-basic terminals.
endif

let g:solarized_use16 = 1 " Use 16 colors when true color is not supported
silent! colorscheme solarized8

" Set light/dark based on time of day.
function! s:nightday() abort
  if strftime('%H') < s:dawn || strftime('%H') + 1 > s:dusk
    if &background !=# 'dark'
      let l:background = 'dark'
    endif
  else
    if &background !=# 'light'
      let l:background = 'light'
    endif
  endif

  if exists('l:background')
    let &background = l:background

    " Reload lightline's colors.
    if exists('g:loaded_lightline')
      " Special cased to handle varient themes.
      if g:colors_name =~# 'solarized\|flattened'
        runtime autoload/lightline/colorscheme/solarized.vim
      else
        execute 'runtime autoload/lightline/colorscheme/'.g:colors_name.'.vim'
      endif
      call lightline#colorscheme()
    endif
  endif
endfunction

" Settings for the auto-changing functionality.
let s:dawn = 5
let s:dusk = 17

" Set light/dark automagically based on time.
call s:nightday()
autocmd vimrc CursorHold * call s:nightday()
