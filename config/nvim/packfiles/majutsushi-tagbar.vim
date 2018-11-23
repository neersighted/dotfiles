nnoremap <leader>q :TagbarToggle<cr>

let g:tagbar_status_func = 'TagbarStatusline'

function! TagbarStatusline(current, sort, fname, ...) abort
  return lightline#statusline(0)
endfunction
