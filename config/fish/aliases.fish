alias git hub
alias ls 'ls -Alh --color'

function gvim
    command gvim --remote-silent $argv
    or command gvim $argv
end
