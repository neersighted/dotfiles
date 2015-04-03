# Real man's LS.
alias ls 'ls -Alh --color'

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
