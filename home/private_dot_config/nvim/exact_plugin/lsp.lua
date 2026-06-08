-- Collect diagnostics into the loclist (buffer)/qflist (workspace).
vim.keymap.set('n', '<leader>e', function() vim.diagnostic.setloclist() end, { desc = 'Buffer diagnostics (loclist)' })
vim.keymap.set('n', '<leader>E', function() vim.diagnostic.setqflist() end, { desc = 'Workspace diagnostics (quickfix)' })
-- Toggle inlay hints (e.g. function parameters)
vim.keymap.set('n', '<leader>i', function()
  local filter = { bufnr = 0 }
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
end, { desc = 'Toggle inlay hints' })

-- Defer the vim.lsp / vim.diagnostic require chains until the first relevant
-- filetype is opened.
local servers = {
  gopls = {
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
  },
  ['rust-analyzer'] = {
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
  },
  pylsp = {
    cmd = { 'pylsp' },
    filetypes = { 'python' },
    root_markers = {
      'pyproject.toml', 'setup.py', 'setup.cfg',
      'requirements.txt', 'Pipfile', '.git',
    },
  },
  lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
          checkThirdParty = false,
        },
      },
    },
  },
  biome = {
    cmd = { 'biome', 'lsp-proxy' },
    filetypes = {
      'javascript', 'javascriptreact',
      'typescript', 'typescriptreact',
      'json', 'jsonc',
    },
    root_markers = { 'biome.json', 'biome.jsonc', 'package.json', '.git' },
  },
}

-- One lazy registration per server, scoped to just its own filetypes.
local all_filetypes = {}
for name, config in pairs(servers) do
  vim.list_extend(all_filetypes, config.filetypes)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = config.filetypes,
    once = true,
    callback = function()
      vim.lsp.config(name, config)
      vim.lsp.enable(name)
    end,
  })
end

-- On attach, set up autocompletion and inlays.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
    if client:supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})

-- Diagnostic UI is global; set it once on the first LSP-relevant buffer.
vim.api.nvim_create_autocmd('FileType', {
  pattern = all_filetypes,
  once = true,
  callback = function()
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
  end,
})
