-- Use clipboard-provider for all clipboard handling.
vim.g.clipboard = {
  name = 'clipboard-provider',
  copy = {
    ['*'] = 'env COPY_PROVIDERS=tmux clipboard-provider copy',
    ['+'] = 'env COPY_PROVIDERS=desktop clipboard-provider copy',
  },
  paste = {
    ['*'] = 'env PASTE_PROVIDERS=tmux clipboard-provider paste',
    ['+'] = 'env PASTE_PROVIDERS=desktop clipboard-provider paste',
  },
  cache_enabled = 1,
}
