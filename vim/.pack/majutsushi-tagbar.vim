nnoremap <leader>b :TagbarToggle<cr>

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
  return lightline#statusline(0)
endfunction
