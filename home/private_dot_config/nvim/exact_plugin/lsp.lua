vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'x',
      [vim.diagnostic.severity.WARN]  = '!',
      [vim.diagnostic.severity.INFO]  = 'i',
      [vim.diagnostic.severity.HINT]  = '?',
    },
  },
  virtual_lines = { current_line = true },
})

vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.work', 'go.mod', '.git' },
  settings = {
    gopls = {
      analyses = { unusedparams = true, unreachable = true },
      staticcheck = true,
      gofumpt = true,
    },
  },
})
vim.lsp.enable('gopls')

vim.lsp.config('rust-analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
  settings = {
    ['rust-analyzer'] = {
      check = { command = 'clippy' },
      cargo = { features = 'all' },
      procMacro = { enable = true },
    },
  },
})
vim.lsp.enable('rust-analyzer')

vim.lsp.config('pylsp', {
  cmd = { 'pylsp' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml', 'setup.py', 'setup.cfg',
    'requirements.txt', 'Pipfile', '.git',
  },
})
vim.lsp.enable('pylsp')
