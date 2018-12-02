let g:startify_bookmarks = [
  \ {'v': '~/.config/nvim/init.vim'},
  \ {'f': '~/.config/fish/config.fish'},
  \ {'t': '~/.config/tmux/tmux.conf'},
  \ {'g': '~/.config/git/config'},
  \ {'i': '~/.config/i3/config'},
  \ ]
let g:startify_commands = [
  \ {'T': ':terminal'},
  \ {'h': ':checkhealth'},
  \ ]

" Show the cursorline in Startify, and don't treat it as a file buffer.
autocmd User Startified setlocal cursorline buftype=nofile
