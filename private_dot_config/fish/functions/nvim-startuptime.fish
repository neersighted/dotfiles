command -q vim-startuptime; or exit

function nvim-startuptime -w vim-startuptime
  vim-startuptime -vimpath nvim $argv
end
