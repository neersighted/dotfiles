let g:ale_virtualtext_cursor = 1

let g:ale_sign_error = 'x'
let g:ale_sign_warning = '!'
let g:ale_echo_msg_format = '[%linter%:%severity%] %code%: %s'

let g:ale_linters = {}
let g:ale_fixers = {}

let g:ale_linters.python = ['pyls']
let g:ale_fixers.python = ['autopep8', 'black']
let g:ale_python_pyls_executable = 'pylsp'

let g:ale_linters.ruby = ['solargraph', 'standardrb']
let g:ale_fixers.ruby = ['remove_trailing_lines', 'standardrb', 'trim_whitespace']

let g:ale_linters.rust = ['rls']
let g:ale_fixers.rust = ['rustfmt']
