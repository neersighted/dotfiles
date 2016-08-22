# Real man's LS.
if ls --color=auto >/dev/null 2>&1
    alias ls 'ls -Alh --color=auto'
else
    alias ls 'ls -Alh -G'
end

# Open in existing Gvim.
function gvim
    command gvim --remote-silent $argv
    or command gvim $argv
end

# CD!
alias - cd\ -
alias .. cd\ ..
alias ... cd\ ../..
alias .... cd\ ../../..
alias ..... cd\ ../../../..
