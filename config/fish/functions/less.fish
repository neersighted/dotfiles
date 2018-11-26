if not set -q LESSOPEN
  # less
  if command -sq lesspipe
    set -x LESSOPEN '|'(command -s lesspipe)' %s'
    set -x LESSCLOSE (command -s lesspipe)' %s %s'
  else if command -sq lesspipe.sh
    set -x LESSOPEN '|'(command -s lesspipe.sh)' %s'
    set -x LESS_ADVANCED_PREPROCESSOR 1
  end
end

function less -d 'less is more'
  command less $argv
end
