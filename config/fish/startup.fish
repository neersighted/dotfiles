# ssh/gpg startup
if status is-login; and not ssh?
  if wsl?
    if not set -q SSH_AUTH_SOCK
      # make sure gpg-agent is up
      command -sq gpg-connect-agent.exe; and gpg-connect-agent.exe /bye >/dev/null 2>&1
      # connect ssh to windows gpg-agent via weasel-pageant
      command -sq weasel-pageant; and weasel-pageant -qrb -a $HOME/.ssh/weasel-pageant.sock -S fish | source
    end
    if test ! -e $GNUPGHOME/S.gpg-agent
      # connect gpg to windows gpg-agent via socat/npiperelay
      wsl-gpg-relay
    end
  else if not string match -rq 'S.gpg-agent.ssh$' $SSH_AUTH_SOCK
    # connect ssh to gpg-agent
    set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  end
end

# tmux/X startup
if not tmux?
  set -l tty (tty)

  if not set -q DISPLAY; and command -sq startx; and string match -rq '^/dev/tty(1|v0)$' $tty
    # start i3 if installed (first tty only)
    command -sq i3; and exec startx $XDG_CONFIG_HOME/xinit/i3
  else if not nvim?
    # determine session name (default to hostname)
    set -l session (prompt_hostname)
    if set -q TERM_PROGRAM; and test $TERM_PROGRAM = 'vscode'
      # separate session for special terminals
      set session $TERM_PROGRAM
    else if ssh?
      # use client suffix for SSH
      set session $session-(string replace -a '.' '-' (string split ' ' $SSH_CONNECTION)[1])
    else if not string match -rq '^/dev/(pts/\d+|ttys\d+)$' $tty; and not wsl?
      # use 'physical' tty
      set session $tty
    end

    # determine startup command
    set -l command
    if string match -q "$session 0" (tmux list-sessions -F '#{session_name} #{session_attached}' 2>/dev/null)
      # attach to unattached session
      set command attach-session -t $session \; run-shell 'pkill -USR1 -P #{pid} fish'
    else if not tmux has-session -t $session 2>/dev/null
      # create non-existant setting
      set command new-session -s $session
    end

    # run tmux startup command
    test -n "$command"; and sleep 0.1; and exec tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf -- $command
  end
end

# non-WSL post-startup
if not wsl?
  set -x GPG_TTY (tty)
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
end

