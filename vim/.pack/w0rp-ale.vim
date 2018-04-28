nnoremap <leader>a <plug>(ale_fix)

let g:ale_echo_msg_format = '[%linter%:%severity%] %s'
let g:ale_sign_warning = '!'
let g:ale_sign_error = 'x'

let g:ale_linters = {}
let g:ale_fixers = {}

let g:ale_linters.python = ['flake8', 'pylint', 'pyls']
let g:ale_fixers.python = ['autopep8']

let g:ale_linters.rust = ['rls', 'rustfmt']
let g:ale_fixers.rust = ['rustfmt']
