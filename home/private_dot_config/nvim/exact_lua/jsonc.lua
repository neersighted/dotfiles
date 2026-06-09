-- Decode JSONC text that vim.json.decode can't handle directly:
-- comments and trailing commas are preprocessed before decoding.
local M = {}

local buffer = require('string.buffer')
local b, char = string.byte, string.char

-- Byte constants, resolved once at load (not re-called per character).
local BACKSLASH = b'\\'
local QUOTE     = b'"'
local SLASH     = b'/'
local STAR      = b'*'
local SPACE     = b' '
local TAB       = b'\t'
local LF        = b'\n'
local CR        = b'\r'
local LBRACE    = b'{'
local RBRACE    = b'}'
local LBRACKET  = b'['
local RBRACKET  = b']'
local COMMA     = b','
local COLON     = b':'

function M.decode(text)
  local n = #text
  local out = buffer.new(n)
  local i, in_str, pending_comma, last = 1, false, false, nil

  while i <= n do
    local c = b(text, i)
    if in_str then
      if c == BACKSLASH then
        local escaped = b(text, i + 1)
        out:put(escaped and char(c, escaped) or char(c))
        i = i + 1
      else
        out:put(char(c))
        if c == QUOTE then in_str, last = false, c end
      end
    elseif c == QUOTE then
      if pending_comma then out:put(','); pending_comma = false end
      in_str, pending_comma = true, false
      out:put('"')
    elseif c == SLASH and b(text, i + 1) == SLASH then
      out:put(' ')
      i = i + 2
      while i <= n and b(text, i) ~= CR and b(text, i) ~= LF do i = i + 1 end
      i = i - 1
    elseif c == SLASH and b(text, i + 1) == STAR then
      local start = i
      i = i + 2
      while i < n and not (b(text, i) == STAR and b(text, i + 1) == SLASH) do i = i + 1 end
      if i < n then out:put(' '); i = i + 1
      else out:put(text:sub(start)); break end
    elseif c == SPACE or c == TAB or c == LF or c == CR then
      out:put(char(c))
    else
      if pending_comma then
        if c ~= RBRACE and c ~= RBRACKET then out:put(',') end
        pending_comma = false
      end
      if c == COMMA and (last and last ~= LBRACKET and last ~= LBRACE and last ~= COMMA and last ~= COLON) then
        pending_comma = true
      else
        out:put(char(c))
      end
      last = c
    end
    i = i + 1
  end

  if pending_comma then out:put(',') end
  return vim.json.decode(out:get())
end

return M
