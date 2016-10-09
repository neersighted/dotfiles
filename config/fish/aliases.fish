# Real man's LS.
if ls --color=auto >/dev/null 2>&1
  alias ls 'ls -Alh --color=auto'
else
  alias ls 'ls -Alh -G'
end

# Open in existing Gvim.
function gvim
  test -n "$argv"; and command gvim --remote-silent $argv; or command gvim
end
