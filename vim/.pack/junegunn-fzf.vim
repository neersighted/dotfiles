if !exists('s:fzf_configured') " Due to a pack bug with duplicated code.
  let s:fzf_configured = 1
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)
  command! -bang -nargs=* GGrep
    \ call fzf#vim#grep(
    \   'git grep --line-number '.shellescape(<q-args>), 0,
    \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

  nnoremap <leader><leader> :Buffers<cr>
  nnoremap <leader>` :Marks<cr>
  nnoremap <leader>/ :BLines<cr>
  nnoremap <leader>? :Lines<cr>
  nnoremap <leader>Gg :GGrep<cr>
  nnoremap <leader>O :GFiles?<cr>
  nnoremap <leader>T :Tags<cr>
  nnoremap <leader>o :Files<cr>
  nnoremap <leader>R :Rg<cr>
  nnoremap <leader>t :BTags<cr>

  nmap <leader>m <plug>(fzf-maps-n)
  omap <leader>m <plug>(fzf-maps-o)
  xmap <leader>m <plug>(fzf-maps-x)

  let g:fzf_statusline = 0 " Use the default statusline.
  let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }
endif
