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

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

function! s:Rg(query, fullscreen)
  let l:basecmd = 'rg --color=always --column --smart-case -- %s || true'
  let l:startcmd = printf(l:basecmd, shellescape(a:query))
  let l:reloadcmd = printf(l:basecmd, '{q}')
  let l:spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.l:reloadcmd]}
  call fzf#vim#grep(basecmd, 1, fzf#vim#with_preview(spec, a:fullscreen ? 'up:60%' : 'right:50%:hidden'), a:fullscreen)
endfunction
command! -bang -nargs=* Rg call s:Rg(<q-args>, <bang>0)

function! s:Ggrep(query, fullscreen)
  let l:basecmd = 'git grep --color=always --column -- %s || true'
  let l:startcmd = printf(l:basecmd, shellescape(a:query))
  let l:reloadcmd = printf(l:basecmd, '{q}')
  let l:spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.l:reloadcmd],
              \ 'dir': systemlist('git rev-parse --show-toplevel')[0]}
  call fzf#vim#grep(basecmd, 1, fzf#vim#with_preview(spec, a:fullscreen ? 'up:60%' : 'right:50%:hidden'), a:fullscreen)
endfunction
command! -bang -nargs=* Ggrep call s:Ggrep(<q-args>, <bang>0)
