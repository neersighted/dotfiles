local starter = require('mini.starter')

starter.setup({
  items = {
    starter.sections.recent_files(12, false), -- global MRU, like startify_files_number
    { name = 'terminal', action = 'terminal', section = 'Commands' },
    { name = 'StartupTime', action = 'StartupTime', section = 'Commands' },
    { name = 'checkhealth', action = 'checkhealth', section = 'Commands' },
    starter.sections.builtin_actions(),
  },
})
