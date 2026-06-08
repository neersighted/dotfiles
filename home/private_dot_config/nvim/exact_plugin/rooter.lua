-- Auto-cd to project root on buffer enter (replaces airblade/vim-rooter).
local markers = {
  '.git',
  'go.mod', 'go.work',
  'Cargo.toml',
  'pyproject.toml', 'setup.py', 'setup.cfg', 'Pipfile',
  'package.json',
  'Gemfile',
}

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function(args)
    if vim.bo[args.buf].buftype ~= '' then return end
    local fname = vim.api.nvim_buf_get_name(args.buf)
    if fname == '' or vim.fn.filereadable(fname) == 0 then return end
    local root = vim.fs.root(args.buf, markers)
    if root and root ~= vim.uv.cwd() then
      vim.cmd.lcd(root)
    end
  end,
})
