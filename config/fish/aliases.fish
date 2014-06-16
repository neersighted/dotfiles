alias g hub
alias l 'ls -Alh'

function gvim
    command gvim --remote-silent $argv
    or command gvim $argv
end
