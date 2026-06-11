-- `ga`: character info from generated chardata; regenerate via :CharinfoUpdate.

local function chardata_path()
  return vim.fn.stdpath('data') .. '/chardata.lua'
end

local chardata
local function read_chardata()
  if chardata then return chardata end
  local chunk, err = loadfile(chardata_path())
  if not chunk then return nil, err end
  local ok, data = pcall(chunk)
  if not ok then return nil, data end
  chardata = data
  return chardata
end

-- char → digraph keystroke, built once from :digraphs (first wins on collision).
local digraphs
local function digraph_for(ch)
  if not digraphs then
    digraphs = {}
    for _, d in ipairs(vim.fn.digraph_getlist(true)) do
      if not digraphs[d[2]] then digraphs[d[2]] = d[1] end
    end
  end
  return digraphs[ch]
end

local function charinfo()
  local ch = vim.fn.strcharpart(vim.api.nvim_get_current_line(), vim.fn.charcol('.') - 1, 1)
  if ch == '' then return end
  local cp = vim.fn.char2nr(ch)

  local data = read_chardata()
  if not data then
    vim.notify('chardata.lua missing (run :CharinfoUpdate)', vim.log.levels.WARN)
    return
  end

  -- Name: direct, then ranges (CJK/Hangul/…), then '?'.
  local name = data.names[cp]
  if not name then
    for _, r in ipairs(data.ranges) do
      if cp >= r[1] and cp <= r[2] then name = r[3]; break end
    end
  end

  local digraph = digraph_for(ch)
  local parts = { ch, ('U+%04X %s'):format(cp, name or '?') }
  if digraph then parts[#parts + 1] = '<c-k>' .. digraph end
  if data.emoji[cp] then parts[#parts + 1] = ':' .. data.emoji[cp] .. ':' end
  if data.entities[cp] then parts[#parts + 1] = data.entities[cp] end
  vim.notify(table.concat(parts, '  '))
end

vim.keymap.set('n', 'ga', charinfo, { desc = 'Character info' })

-- Fetch all URLs concurrently; returns { key = body } once every request completes.
local function fetch_all(urls)
  local bodies, errs, pending = {}, {}, 0
  for key, url in pairs(urls) do
    pending = pending + 1
    vim.net.request(url, {}, function(err, res)
      if err or not res or res.body == '' then
        errs[key] = err or 'empty response'
      else
        bodies[key] = res.body
      end
      pending = pending - 1
    end)
  end
  if not vim.wait(120000, function() return pending == 0 end, 50) then
    error('fetch timed out')
  end
  if next(errs) then error('fetch failed: ' .. vim.inspect(errs)) end
  return bodies
end

local function generate()
  local src = fetch_all({
    unicode = 'https://unicode.org/Public/UNIDATA/UnicodeData.txt',
    entities = 'https://html.spec.whatwg.org/entities.json',
    emoji = 'https://api.github.com/emojis',
  })

  -- Names + First/Last ranges.
  local names, ranges, firsts = {}, {}, {}
  for line in vim.gsplit(src.unicode, '\n', { plain = true }) do
    if line ~= '' then
      local f = vim.split(line, ';', { plain = true })
      local code, nm, u1 = tonumber(f[1], 16), f[2], f[11]
      local first = nm:match('^<(.-), First>$')
      local last = nm:match('^<(.-), Last>$')
      if first then
        firsts[first] = code
      elseif last then
        ranges[#ranges + 1] = { firsts[last], code, '<' .. last .. '>' }
      else
        if nm:match('^<') and u1 ~= '' then nm = u1 end -- <control> etc.: prefer the Unicode-1 name
        names[code] = nm
      end
    end
  end

  -- Single-codepoint named entities; shortest then lowercase keeps regen byte-stable.
  local entities = {}
  for key, v in pairs(vim.json.decode(src.entities)) do
    if key:sub(-1) == ';' and #v.codepoints == 1 then
      local cp, cur = v.codepoints[1], entities[v.codepoints[1]]
      if not cur or #key < #cur or (#key == #cur and key > cur) then entities[cp] = key end
    end
  end

  -- Single-codepoint shortcodes from the image URLs; longest then lex keeps regen byte-stable.
  local emoji = {}
  for name, url in pairs(vim.json.decode(src.emoji)) do
    local hex = url:match('/unicode/(%x+)%.png')
    if hex then
      local cp, cur = tonumber(hex, 16), emoji[tonumber(hex, 16)]
      if not cur or #name > #cur or (#name == #cur and name < cur) then emoji[cp] = name end
    end
  end

  return { names = names, ranges = ranges, entities = entities, emoji = emoji }
end

local buffer = require('string.buffer')

-- Serialize to chardata.lua via string.buffer.
local function write_chardata(data)
  local path = chardata_path()
  vim.fn.mkdir(vim.fn.fnamemodify(path, ':h'), 'p')
  -- Pre-size from the previous file.
  local out = buffer.new((vim.uv.fs_stat(path) or {}).size or 0)

  local function put_map(map)
    local keys, n = {}, 0
    for k in pairs(map) do n = n + 1; keys[n] = k end
    table.sort(keys)
    for i = 1, n do
      local k = keys[i]
      out:putf('    [0x%X] = %q,\n', k, map[k])
    end
  end

  out:put('-- @generated using :CharinfoUpdate\nreturn {\n  names = {\n')
  put_map(data.names)
  out:put('  },\n  ranges = {\n')
  for i = 1, #data.ranges do
    local r = data.ranges[i]
    out:putf('    { 0x%X, 0x%X, %q },\n', r[1], r[2], r[3])
  end
  out:put('  },\n  entities = {\n')
  put_map(data.entities)
  out:put('  },\n  emoji = {\n')
  put_map(data.emoji)
  out:put('  },\n}\n')

  local f = assert(io.open(path, 'w'))
  f:write(out:get())
  f:close()
end

vim.api.nvim_create_user_command('CharinfoUpdate', function()
  local data = generate()
  write_chardata(data)
  chardata = data
  vim.notify(('chardata.lua updated: %d names, %d ranges, %d entities, %d emoji')
    :format(vim.tbl_count(data.names), #data.ranges, vim.tbl_count(data.entities), vim.tbl_count(data.emoji)))
end, { desc = 'Regenerate chardata.lua from source data' })
