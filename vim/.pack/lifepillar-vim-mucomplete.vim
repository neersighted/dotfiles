nnoremap <leader><tab> :call mucomplete#toggle_auto()<cr>

imap <expr> <up> pumvisible() ? "\<plug>(MUcompleteExtendBwd)" : "\<up>"
imap <expr> <down> pumvisible() ? "\<plug>(MUcompleteExtendFwd)" : "\<down>"

imap <plug>MuCR <plug>(MUcompleteCR)
imap <cr> <plug>MuCR

let g:mucomplete#chains = {}
let g:mucomplete#chains.default = ['path', 'omni', 'keyn', 'dict', 'uspl']
let g:mucomplete#chains.markdown = ['keyn', 'dict', 'uspl']
let g:mucomplete#chains.vim = ['path', 'cmd', 'keyn']
