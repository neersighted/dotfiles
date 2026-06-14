-- Toggle inlay hints (e.g. function parameters)
vim.keymap.set('n', '<leader>i', function()
  local filter = { bufnr = 0 }
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
end, { desc = 'Toggle inlay hints' })

-- Configure diagnostic characters; enable support for virtual lines.
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

-- SchemaSource catalogs by filetype, along with merge logic and settings.json key.
local SchemaStore = {
  -- json.schemas: list of { fileMatch = {globs}, url }; project wins first-match.
  JSON = {
    catalog = function() return require('schemastore').json.schemas() end,
    merge = function(catalog, project) return vim.list_extend(project, catalog) end,
    key = 'json.schemas',
  },
  -- yaml.schemas: { uri = glob(s) } map; project keys override the catalog.
  YAML = {
    catalog = function() return require('schemastore').yaml.schemas() end,
    merge = function(catalog, project)
      for uri, patterns in pairs(project) do catalog[uri] = patterns end
      return catalog
    end,
    key = 'yaml.schemas',
  },
}

-- Overlay schemas found in VS Code settings.json (JSONC) onto SchemaStore.
local function vscode_schemastore(kind, root)
  local catalog = kind.catalog()
  local file = io.open((root or vim.uv.cwd()) .. '/.vscode/settings.json', 'r')
  if not file then return catalog end
  local text = file:read('*a')
  file:close()

  local ok, decoded = pcall(require('jsonc').decode, text)
  local project = ok and type(decoded) == 'table' and decoded[kind.key] or nil
  if not project then return catalog end

  return kind.merge(catalog, project)
end

-- This nvim config: either the installed copy, or the chezmoi source.
local function is_nvim_config(root)
  if not root then return false end
  return root == vim.fn.stdpath('config')
    or vim.uv.fs_stat(root .. '/.chezmoiroot') ~= nil
end

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
  ty = {
    cmd = { 'ty', 'server' },
    filetypes = { 'python' },
    root_markers = {
      'pyproject.toml', 'ty.toml',
      'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git',
    },
  },
  ruff = {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = {
      'pyproject.toml', 'ruff.toml', '.ruff.toml',
      'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git',
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
        workspace = { checkThirdParty = false },
      },
    },
    before_init = function(_, config)
      if is_nvim_config(config.root_dir) then
        config.settings.Lua.workspace.library = vim.api.nvim_get_runtime_file('', true)
      end
    end,
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
  jsonls = {
    cmd = { 'vscode-json-language-server', '--stdio' },
    filetypes = { 'json', 'jsonc' },
    root_markers = { '.git' },
    init_options = { provideFormatter = false },
    settings = {
      json = {
        validate = { enable = true },
      },
    },
    before_init = function(_, config)
      config.settings.json.schemas = vscode_schemastore(SchemaStore.JSON, config.root_dir)
    end,
  },
  yamlls = {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
    root_markers = { '.git' },
    settings = {
      yaml = {
        schemaStore = { enable = false, url = '' },
      },
    },
    before_init = function(_, config)
      config.settings.yaml.schemas = vscode_schemastore(SchemaStore.YAML, config.root_dir)
    end,
  },
}

-- Register and enable (FileType autocmd) each defined server.
for name, config in pairs(servers) do
  vim.lsp.config(name, config)
end
vim.lsp.enable(vim.tbl_keys(servers))
