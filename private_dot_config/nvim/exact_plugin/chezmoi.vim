augroup chezmoi
  autocmd!
  autocmd BufWritePost ~/.local/share/chezmoi/* silent execute '!chezmoi apply --source-path %'
augroup END
