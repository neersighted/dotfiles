# Vim improved!
alias vim nvim

# Real man's LS.
if ls --color=auto >/dev/null 2>&1
  alias ls 'ls -Alh --color=auto'
else
  alias ls 'ls -Alh -G'
end
