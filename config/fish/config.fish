if not set -qU fish_initialized
  # mark shell initialized
  set -U fish_initialized
end

# ssh/gpg startup
if status --is-login; and not set -qg SSH_CONNECTION
  if set -qg WSL
    if not set -qg SSH_AUTH_SOCK
      # make sure gpg-agent is up
      command -sq gpg-connect-agent.exe; and gpg-connect-agent.exe /bye >/dev/null 2>&1
      # connect ssh to windows gpg-agent via weasel-pageant
      command -sq weasel-pageant; and weasel-pageant -q -S fish | source
    end
    if test ! -e $GNUPGHOME/S.gpg-agent
      # connect gpg to windows gpg-agent via socat/npiperelay
      command -sq npiperelay.exe; and gpg-relay (command -s npiperelay.exe)
    end
  else if not string match -q -r 'S.gpg-agent.ssh$' $SSH_AUTH_SOCK
    # connect ssh to gpg-agent
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  end
end

# tmux/X startup
if status --is-interactive; and not set -qg TMUX
  set -l tty (tty)

  if not set -qg DISPLAY; and command -sq startx; and string match -q -r '^/dev/tty(1|v0)$' $tty
    # start i3 if installed (first tty only)
    command -sq i3; and exec startx $XDG_CONFIG_HOME/xinit/i3
  else
    set -l session

    # determine session name
    if set -qg SSH_CONNECTION
      # use ssh client name
      set session (string replace --all '.' '-' (string split ' ' $SSH_CONNECTION)[1])
    else if string match -q -r '^/dev/(pts/\d+|ttys\d+)$' $tty
      # use local-pty tmux session
      set session (hostname -s)
    else
      # use 'physical' tty
      set session $tty
    end

    # create or attach to tmux session
    if tmux has-session -t $session
      tmux attach-session -t $session \; run-shell 'pkill -USR1 -P #{pid} fish'
    else
      tmux new-session -s $session
    end
  end
end

# non-WSL post-startup
if status --is-interactive; and not set -qg WSL
  set -gx GPG_TTY (tty)
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
end
