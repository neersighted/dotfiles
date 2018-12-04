let g:ale_virtualtext_cursor = 1

let g:ale_sign_error = 'x'
let g:ale_sign_warning = '!'
let g:ale_echo_msg_format = '[%linter%:%severity%] %code%: %s'

let g:ale_linters = {}
let g:ale_fixers = {}

let g:ale_linters.python = ['pylint', 'pyls']
let g:ale_fixers.python = ['autopep8', 'black']
let g:ale_python_black_options = '--line-length 79'
let g:ale_python_mypy_options = '--strict'
let g:ale_python_mypy_ignore_invalid_syntax = 1

let g:ale_linters.rust = ['rls']
let g:ale_fixers.rust = ['rustfmt']
