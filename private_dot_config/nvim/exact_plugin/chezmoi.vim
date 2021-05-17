augroup chezmoi
  autocmd!
  autocmd BufWritePost ~/.local/share/chezmoi/* silent execute '!chezmoi apply --exclude scripts --source-path %'
augroup END
