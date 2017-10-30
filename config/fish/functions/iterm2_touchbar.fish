function iterm2_touchbar --on-event fish_postexec
  test -n "$ITERM2"
    and ~/.iterm2/it2setkeylabel set status (pwd)
end

