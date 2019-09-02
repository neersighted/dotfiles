function __gpg-agent_auto_start -d 'manage gpg-agent startup' -a tty
  test -n "$tty"; or set tty (tty)

  if wsl?
    # make sure gpg-agent is up
    gpg-connect-agent.exe /bye >/dev/null 2>&1
    # connect ssh to windows gpg-agent via weasel-pageant
    set -q SSH_AUTH_SOCK; or weasel-pageant -qrb -a $HOME/.ssh/weasel-pageant.sock -S fish | source
    # connect gpg to windows gpg-agent via socat/npiperelay
    test -e $GNUPGHOME/S.gpg-agent; or wsl-gpg-relay
  else if not string match -rq 'S.gpg-agent.ssh$' $SSH_AUTH_SOCK
    # connect ssh to gpg-agent
    set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  end

  function __gpg-agent_after_start -e fish_prompt
    if not wsl?
      # rebind gpg-agent to the correct tty
      set -gx GPG_TTY $tty
      gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1 &
    end

    functions -e __gpg-agent_after_start
  end
end
