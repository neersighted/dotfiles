"
" Discreet
"

" Buffer
autocmd vimrc User asynccomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
  \ 'name': 'buffer',
  \ 'whitelist': ['*'],
  \ 'completor': function('asyncomplete#sources#buffer#completor'),
  \ }))

" Filename
autocmd vimrc User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
  \ 'name': 'file',
  \ 'whitelist': ['*'],
  \ 'priority': 10,
  \ 'completor': function('asyncomplete#sources#file#completor'),
  \ }))

" Go
autocmd vimrc User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#gocode#get_source_options({
  \ 'name': 'gocode',
  \ 'whitelist': ['go'],
  \ 'completor': function('asyncomplete#sources#gocode#completor'),
  \ }))

" Javascript
autocmd vimrc User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#flow#get_source_options({
  \ 'name': 'flow',
  \ 'whitelist': ['javascript'],
  \ 'config': { 'prefer_local': 1, 'show_typeinfo': 1 },
  \ 'completor': function('asyncomplete#sources#flow#completor'),
  \ }))

" Rust
autocmd vimrc User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#racer#get_source_options())

" Syntax
autocmd vimrc User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
  \ 'name': 'necosyntax',
  \ 'whitelist': ['*'],
  \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
  \ }))

" Tmux
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

" Omnifunc
autocmd vimrc User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
  \ 'name': 'omni',
  \ 'whitelist': ['*'],
  \ 'blacklist': ['c', 'cpp', 'html'],
  \ 'completor': function('asyncomplete#sources#omni#completor'),
  \ }))

" Tags
autocmd vimrc User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
  \ 'name': 'tags',
  \ 'whitelist': ['*'],
  \ 'completor': function('asyncomplete#sources#tags#completor'),
  \ }))

" VimL
autocmd vimrc User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
  \ 'name': 'necovim',
  \ 'whitelist': ['vim'],
  \ 'completor': function('asyncomplete#sources#necovim#completor'),
  \ }))

"
" LSP
"

" C/C++ (clangd)
if executable('clangd')
  autocmd vimrc User lsp_setup call lsp#register_server({
    \ 'name': 'clangd',
    \ 'cmd': {server_info->['clangd']},
    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
    \ })
endif

" C/C++ (cquery)
if executable('cquery')
  autocmd vimrc User lsp_setup call lsp#register_server({
    \ 'name': 'cquery',
    \ 'cmd': {server_info->['cquery']},
    \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
    \ })
endif

" Python
if executable('pyls')
  autocmd vimrc User lsp_setup call lsp#register_server({
    \ 'name': 'pyls',
    \ 'cmd': {server_info->['pyls']},
    \ 'whitelist': ['python'],
    \ })
endif

