" Show the cursorline in Startify, and don't treat it as a file buffer.
augroup startify_settings
  autocmd!
  autocmd User Startified setlocal cursorline buftype=nofile
augroup END

let g:startify_commands = [
  \ {'T': ':terminal'},
  \ {'h': ':checkhealth'},
  \ ]

let g:startify_change_to_vcs_root = 1 " Switch to root when opening file.
let g:startify_files_number = 12 " Show more files.
