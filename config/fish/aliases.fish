# Real man's LS.
if ls --color=auto >/dev/null 2>&1
  alias ls 'ls -Alh --color=auto'
else
  alias ls 'ls -Alh -G'
end

if which nvim >/dev/null 2>&1 # Neovim if we got it.
  alias vim nvim
end

function gvim # Open in existing Gvim.
  test -n "$argv"; and command gvim --remote-silent $argv; or command gvim
end
