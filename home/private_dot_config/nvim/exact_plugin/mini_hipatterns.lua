local hipatterns = require('mini.hipatterns')

hipatterns.setup({
  highlighters = {
    -- Highlight standalone attention words.
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack' },
    todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo' },
    note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote' },

    -- Highlight #rrggbb hex strings with the color itself.
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})
