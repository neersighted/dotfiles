nnoremap <leader><tab> :call mucomplete#toggle_auto()<cr>

imap <expr> <up> pumvisible() ? "\<plug>(MUcompleteExtendBwd)" : "\<up>"
imap <expr> <down> pumvisible() ? "\<plug>(MUcompleteExtendFwd)" : "\<down>"

let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['path', 'omni', 'keyn', 'dict', 'uspl']
let g:mucomplete#chains.markdown = ['keyn', 'dict', 'uspl']
let g:mucomplete#chains.vim = ['path', 'cmd', 'keyn']

"
" Python
"

let g:jedi#completions_command = ''
let g:jedi#show_call_signatures = '2'

"
" Rust
"

let g:racer_experimental_completer = 1

"
" Tags
"

" Locate a working ctags implementation.
if executable('uctags')
  let g:gutentags_ctags_executable = 'uctags'
elseif executable('exctags')
  let g:gutentags_ctags_executable = 'exctags'
endif


"
" tmux
"

let g:tmuxcomplete#asyncomplete_source_options = {
  \ 'name': 'tmuxcomplete',
  \ 'whitelist': ['*'],
  \ 'config': {
  \   'splitmode':      'words',
  \   'filter_prefix':   1,
  \   'show_incomplete': 1,
  \   'sort_candidates': 0,
  \   'scrollback':      0,
  \   'truncate':        0
  \   }
  \ }
