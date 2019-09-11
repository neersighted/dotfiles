if not set -q LESSOPEN
  if set -l lesspipe (command -s lesspipe)
    set -x LESSOPEN "$lesspipe %s"
    set -x LESSCLOSE "$lesspipe %s %s"
  else if set -l lesspipe (command -s lesspipe.sh)
    set -x LESSOPEN "|$lesspipe %s"
    set -x LESS_ADVANCED_PREPROCESSOR 1
  end
end
