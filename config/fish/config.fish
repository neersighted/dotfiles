# mark shell initialized
if not set -qU fish_initialized
  set -U fish_initialized
end

# lazily cache tty
set -l tty

# local startup and setup
if not set -qg TMUX; and not set -qg SSH_CLIENT; and not set -qg QUICKTERM
  if status --is-login
    if command -sq weasel-pageant; and command -sq gpg-connect-agent.exe
      # connect ssh to windows gpg-agent via weasel-pageant
      gpg-connect-agent.exe /bye >/dev/null 2>&1
      source (weasel-pageant -q -S fish | psub)
    else
      # connect ssh to gpg-agent (if not already wired up)
      set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    end
  end

  if status --is-interactive
    set tty (tty)

    if not set -qg DISPLAY; and string match -q -r '^/dev/tty(1|v0)$' $tty
      # start i3 if installed (first tty only)
      command -sq i3; and exec startx $XDG_CONFIG_HOME/xinit/i3
    else
      set -l session

      if string match -q -r '^/dev/(pts/\d+|ttys\d+)$' $tty
        # use shared tmux session (pseudoterminals only)
        set session (prompt_hostname)
      else
        # use tty-specific tmux session
        set session $tty
      end

      # create or attach to tmux session
      tmux new-session -A -s $session
    end
  end
end

# non-WSL post-startup
if status --is-interactive; and test -f $GNUPGHOME/S.gpg-agent
  if test -z "$tty"
    set tty (tty)
  end

  set -gx GPG_TTY $tty
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
end
