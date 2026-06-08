local starter = require('mini.starter')

-- Index the recent-file sections with mnemonic, per-section prefixes
-- (r = global recents, c = cwd recents) and a number that restarts each
-- section. mini's built-in indexing only cycles a/b/c…, so roll our own.
-- Sections absent from the map (Commands, Builtin actions) stay unindexed.
local section_prefix = {
  ['Recent files'] = 'r',
  ['Recent files (current directory)'] = 'c',
}
local function indexing_named(content)
  local cur_section, n_item = nil, 0
  for _, c in ipairs(starter.content_coords(content, 'item')) do
    local unit = content[c.line][c.unit]
    local prefix = section_prefix[unit.item.section]
    if prefix then
      if cur_section ~= unit.item.section then
        cur_section, n_item = unit.item.section, 0
      end
      n_item = n_item + 1
      unit.string = ('%s%d. %s'):format(prefix, n_item, unit.string)
    end
  end
  return content
end

starter.setup({
  evaluate_single = true,
  items = {
    starter.sections.recent_files(9, false), -- global most-recently-used
    starter.sections.recent_files(9, true),  -- recents scoped to the cwd
    { name = 'terminal', action = 'terminal', section = 'Commands' },
    { name = 'StartupTime', action = 'StartupTime', section = 'Commands' },
    { name = 'checkhealth', action = 'checkhealth', section = 'Commands' },
    starter.sections.builtin_actions(),
  },
  content_hooks = {
    starter.gen_hook.adding_bullet(),
    indexing_named,
    starter.gen_hook.aligning('center', 'center'), -- left-justified block, centered like startify
  },
})
