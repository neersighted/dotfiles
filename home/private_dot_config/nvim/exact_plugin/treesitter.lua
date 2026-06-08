require('tree-sitter-manager').setup({
  ensure_installed = {
    'bash', 'diff', 'fish', 'gitcommit', 'go', 'javascript', 'json',
    'lua', 'markdown', 'markdown_inline', 'python', 'ruby', 'rust',
    'toml', 'vim', 'vimdoc', 'yaml',
  },
  auto_install = true,
})
