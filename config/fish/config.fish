# mark shell initialized
set -q fish_initialized; or set -U fish_initialized

# ssh/gpg startup
if status is-login; and not set -q SSH_CONNECTION
  if set -q WSL
    if not set -q SSH_AUTH_SOCK
      # make sure gpg-agent is up
      command -sq gpg-connect-agent.exe; and gpg-connect-agent.exe /bye >/dev/null 2>&1
      # connect ssh to windows gpg-agent via weasel-pageant
      command -sq weasel-pageant; and weasel-pageant -qrb -a $HOME/.ssh/weasel-pageant.sock -S fish | source
    end
    if test ! -e $GNUPGHOME/S.gpg-agent
      # connect gpg to windows gpg-agent via socat/npiperelay
      command -sq npiperelay.exe; and gpg-relay (command -s npiperelay.exe)
    end
  else if not string match -rq 'S.gpg-agent.ssh$' $SSH_AUTH_SOCK
    # connect ssh to gpg-agent
    set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  end
end

# tmux/X startup
if status is-interactive; and not set -q TMUX
  set -l tty (tty)

  if not set -q DISPLAY; and command -sq startx; and string match -rq '^/dev/tty(1|v0)$' $tty
    # start i3 if installed (first tty only)
    command -sq i3; and exec startx $XDG_CONFIG_HOME/xinit/i3
  else
    # determine session name (default to hostname)
    set -l session (string split . $hostname)[1]
    if set -q SSH_CONNECTION
      # use client suffix for SSH
      set session $session-(string replace -a '.' '-' (string split ' ' $SSH_CONNECTION)[1])
    else if not string match -rq '^/dev/(pts/\d+|ttys\d+)$' $tty; and not set -q WSL
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
if status is-interactive; and not set -q WSL
  set -x GPG_TTY (tty)
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
end
