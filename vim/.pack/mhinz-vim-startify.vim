let g:startify_bookmarks = [
  \ {'v': '~/.vim/vimrc'},
  \ {'f': '~/.config/fish/config.fish'},
  \ {'t': '~/.tmux.conf'},
  \ {'g': '~/.config/git/config'},
  \ {'w': '~/.config/i3/config'},
  \ {'x': '~/.xinitrc'},
  \ {'X': '~/.xsession'},
  \ ]
let g:startify_commands = [
  \ {'T': ':terminal'},
  \ {'h': ':checkhealth'},
  \ ]

" Show the cursorline in Startify, and don't treat it as a file buffer.
autocmd User Startified setlocal cursorline buftype=nofile
