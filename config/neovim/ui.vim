" Color
if strftime("%H") >= 5 && strftime("%H") <= 17 " Set colors based on the time of day.
  colorscheme flattened_light
else
  colorscheme flattened_dark
endif
set termguicolors " Use true colors.
set t_8f=[38;2;%lu;%lu;%lum " Fix 24-bit color escape sequences.
set t_8b=[48;2;%lu;%lu;%lum " This supports st, tmux, and iterm2.

" Font
set guifont=Source\ Code\ Pro\ 10 " Use my font of choice.
set guioptions=ai " Hide all GUI widgets.

" Status
set noshowmode noshowcmd " Disable the built in status indicators.

" Input
set ttimeoutlen=50 timeoutlen=300 " Make escape/keybinds faster.

" Clipboard
set clipboard=unnamedplus " Use the system clipboard.

" Misc
set lazyredraw " Redraw less for performance's sake.
set noerrorbells novisualbell " Turn off bells.
