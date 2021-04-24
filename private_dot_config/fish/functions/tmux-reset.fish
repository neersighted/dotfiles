function tmux-reset
  for client_tty in (tmux list-clients -F '#{client_tty}')
    printf "\033c" > $client_tty
    stty sane > $client_tty
    tmux refresh -t $client_tty
  end
end
