-- cd to project root on buffer enter (replaces airblade/vim-rooter).
local M = {}

M.markers = {
  '.git',
  'go.mod', 'go.work',
  'Cargo.toml',
  'pyproject.toml', 'setup.py', 'setup.cfg', 'Pipfile',
  'package.json',
  'Gemfile',
}

function M.find(buf)
  return vim.fs.root(buf or 0, M.markers)
end

vim.api.nvim_create_autocmd('BufEnter', {
  callback = function(args)
    if vim.bo[args.buf].buftype ~= '' then return end
    local fname = vim.api.nvim_buf_get_name(args.buf)
    if fname == '' or vim.fn.filereadable(fname) == 0 then return end
    local dir = M.find(args.buf)
    if dir and dir ~= vim.uv.cwd() then
      vim.cmd.lcd(vim.fn.fnameescape(dir))
    end
  end,
})

return M
