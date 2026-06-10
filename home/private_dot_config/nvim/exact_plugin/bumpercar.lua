-- bumpercar: gentler collisions between editors sharing a file.
--   * classify swap collisions (live peer vs. stale crash leftover)
--   * on refocus (editor/buffer), check for changes on disk

local grp = vim.api.nvim_create_augroup('bumpercar', { clear = true })

-- Is `pid` a live process on this machine? Use SIG 0 to probe a PID:
-- 0/alive, ESRCH/gone, EPERM/alive-but-not-ours.
local function process_alive(pid)
  if type(pid) ~= 'number' or pid <= 0 then return false end
  local ok, err = vim.uv.kill(pid, 0)
  return ok == 0 or (err ~= nil and err:find('EPERM') ~= nil)
end

local function basename(path)
  return vim.fn.fnamemodify(path, ':t')
end

-- On a swap collision, decide automatically what to do.
vim.api.nvim_create_autocmd('SwapExists', {
  group = grp,
  desc = 'Classify swap collisions and answer without prompting',
  callback = function()
    local info = vim.fn.swapinfo(vim.v.swapname)

    -- The swap file is unreadable; continue editing.
    if info.error then
      vim.v.swapchoice = 'e'
    -- The other nvim is alive; go read-only.
    elseif info.host == vim.uv.os_gethostname() and process_alive(info.pid) then
      vim.v.swapchoice = 'o'
      vim.notify(
        ('%s is open in nvim (pid %d) - opening read-only'):format(basename(vim.v.swapname), info.pid),
        vim.log.levels.WARN)
    -- The other nvim exited unexpectedly; suggest :recover and continue.
    elseif info.dirty == 1 then
      vim.v.swapchoice = 'e'
      vim.notify(
        ('%s has unsaved changes in swapfile - :recover to inspect'):format(basename(vim.v.swapname)),
        vim.log.levels.WARN)
    -- The swapfile is clean; delete it and continue.
    else
      vim.v.swapchoice = 'd'
    end
  end,
})

-- Reload open buffers when a refocus event happens; a modified
-- buffer that was written under will still trigger the default prompt.
vim.o.autoread = true
vim.api.nvim_create_autocmd('FocusGained', {
  group = grp,
  desc = 'Check for external file change on refocus',
  callback = function()
    if vim.fn.getcmdwintype() == '' then
      pcall(vim.cmd.checktime) -- Check all buffers.
    end
  end,
})

-- Navigating to a buffer/tab/split within nvim: re-check the one we land on.
vim.api.nvim_create_autocmd('BufEnter', {
  group = grp,
  desc = 'Check the entered buffer for external change',
  callback = function(args)
    if vim.fn.getcmdwintype() == '' then
      pcall(vim.cmd.checktime, args.buf) -- Check the entered buffer.
    end
  end,
})

vim.api.nvim_create_autocmd('FileChangedShellPost', {
  group = grp,
  desc = 'Notify when a buffer was reloaded from disk',
  callback = function(args)
    vim.notify(('%s changed on disk — buffer reloaded'):format(basename(args.file)), vim.log.levels.INFO)
  end,
})
