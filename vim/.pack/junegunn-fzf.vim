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
  nnoremap <leader>o :Files<cr>
  nnoremap <leader>O :GFiles<cr>
  nnoremap <leader>C :GFiles?<cr>
  nnoremap <leader>r :Rg<cr>
  nnoremap <leader>G :GGrep<cr>
  nnoremap <leader>f :BLines<cr>
  nnoremap <leader>F :Lines<cr>
  nnoremap <leader>t :BTags<cr>
  nnoremap <leader>T :Tags<cr>
  nnoremap <leader>h :BCommits<cr>
  nnoremap <leader>H :Commits<cr>
  nnoremap <leader>` :Marks<cr>
  nnoremap <leader>? :Helptags<cr>
  nmap <leader><tab> <plug>(fzf-maps-n)
  xmap <leader><tab> <plug>(fzf-maps-x)
  omap <leader><tab> <plug>(fzf-maps-o)

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
