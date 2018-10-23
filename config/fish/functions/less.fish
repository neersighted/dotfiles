if not set -qg LESSOPEN
  # less
  if command -sq lesspipe
    set -gx LESSOPEN "|"(command -s lesspipe)" %s"
    set -gx LESSCLOSE (command -s lesspipe)" %s %s"
  else if command -sq lesspipe.sh
    set -gx LESSOPEN "|"(command -s lesspipe.sh)" %s"
    set -gx LESS_ADVANCED_PREPROCESSOR 1
  end
end

function less -d 'less is more'
  command less --quit-if-one-screen $argv
end
