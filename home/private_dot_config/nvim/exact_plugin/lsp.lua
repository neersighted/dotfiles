-- Defer all vim.lsp / vim.diagnostic loading until the first relevant
-- filetype is opened. Saves the entire vim.lsp framework require chain
-- from startup.
local lsp_filetypes = {
  'go', 'gomod', 'gowork', 'gotmpl',
  'rust',
  'python',
  'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'jsonc',
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = lsp_filetypes,
  once = true,
  callback = function(args)
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

    vim.lsp.config('biome', {
      cmd = { 'biome', 'lsp-proxy' },
      filetypes = {
        'javascript', 'javascriptreact',
        'typescript', 'typescriptreact',
        'json', 'jsonc',
      },
      root_markers = { 'biome.json', 'biome.jsonc', 'package.json', '.git' },
    })
    vim.lsp.enable('biome')

    -- vim.lsp.enable just registered FileType autocmds, but FileType already
    -- fired for this buffer. Re-fire so the LSP attaches.
    vim.api.nvim_exec_autocmds('FileType', { buffer = args.buf })
  end,
})
