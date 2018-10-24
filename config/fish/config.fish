# we've finished universal configuration initialization at this point
if not set -qU fish_initialized
  set -U fish_initialized
end

# login session logic (environment)
if status --is-login
  # systemd --user (non-WSL systemd only)
  if not set -qg WSL; and command -sq systemctl
    systemctl --user import-environment PATH 2>/dev/null
  end

  # gpg-agent/ssh (local only)
  if not set -qg SSH_TTY; and not set -qg MOSH
    if set -qg WSL; and command -sq weasel-pageant; and command -sq gpg-connect-agent.exe
      gpg-connect-agent.exe /bye >/dev/null 2>&1
      source (weasel-pageant -q -S fish | psub)
    else
      gpg-agent --pinentry-program $HOME/.local/bin/pinentry --daemon 2>/dev/null
      set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    end
  end
end

# per-shell statup logic
if status --is-interactive
  # 24bit color
  if test $COLORTERM = 'truecolor'
    set -g fish_term24bit 1
  end

  # pinentry tty (non-WSL only)
  if not set -qg WSL
    set -x GPG_TTY (tty)
    gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
  end
end

# login shell startup logic
if status --is-login; and status --is-interactive
  if set -qg WSL; or string match -q -r '(ttys|pts)' (tty); and not set -qg TMUX
    # start our main tmux session (on a pts)
    set -l session (prompt_hostname)
    if tmux has-session -t $session 2>/dev/null
      tmux new-session -t $session\; set-option destroy-unattached
    else
      tmux new-session -s $session
    end
  else if test $XDG_VTNR -eq 1; or command -sq vidcontrol; and test (vidcontrol -i active 2>/dev/null) -eq 1
    # start our X11 session (on tty1)
    exec startx
  end
end

# vi:ft=fish:
