# first-time universal variable provisioning
# this allows variables to be overridden locally with set -U(x)
# set -Ue fish_initialized to reset
if not set -qU fish_initialized;
  set -U fish_initialized
end

# session init (environmental variables)
if status --is-login
  # load system profile (with bass)
  if type -q bass
    bass source /etc/profile
  end

  # xdg (bsd compat)
  if not set -qx XDG_VTNR; and type -q vidcontrol
    set -x XDG_VTNR (vidcontrol -i active 2>/dev/null)
  end

  # xdg
  if not set -qx XDG_CONFIG_HOME
    set -x XDG_CONFIG_HOME $HOME/.config
  end
  if not set -qx XDG_DATA_HOME
    set -x XDG_DATA_HOME $HOME/.local/share
  end
  if not set -qx XDG_CACHE_HOME
    set -x XDG_CACHE_HOME $HOME/.cache
  end

  # ccache
  path_prepend /usr/local/opt/ccache/libexec # macos
  path_prepend /usr/local/libexec/ccache # bsd
  path_prepend /usr/lib/ccache/bin # linux

  # personal
  path_prepend $HOME/.local/bin # dotfiles
  path_prepend $GOPATH/bin $GOENV_ROOT/shims $GOENV_ROOT/bin # golang
  path_prepend $NODENV_ROOT/shims $NODENV_ROOT/bin # nodejs
  path_prepend $PIPX_BIN_DIR $PYENV_ROOT/shims $PYENV_ROOT/bin # python
  path_prepend $RBENV_ROOT/shims $RBENV_ROOT/bin # ruby
  path_prepend $CARGO_HOME/bin # rust

  # notify systemd of path
  if type -q systemctl
    systemctl --user import-environment PATH 2>/dev/null
  end

  # coreutils
  if type -q dircolors
    source (dircolors -c ~/.dircolors | psub)
  else if type -q gdircolors
    source (gdircolors -c ~/.dircolors | psub)
  end

  # less
  if type -q lesspipe
    source (env SHELL=csh lesspipe | psub)
  else if type -q lesspipe.sh
    source (env SHELL=csh lesspipe.sh | psub)
  end

  # mosh detection
  set parent (ps -o comm= (ps -o ppid= %self | tr -d '[:space:]'))
  if test "$parent" = "mosh-server"
    set -x MOSH 1
  end

  # wsl detection/fixup
  if string match -q -e "Microsoft" (uname -r)
    set -x SHELL (command -v fish)
    set -x DISPLAY :0
    set -x WSL 1
  end
end

# per-shell setup logic
if status --is-interactive
  # use 24bit color in non-basic terminals
  if test "$TERM" != "xterm"; and test "$TERM" != "linux"
    set -g fish_term24bit 1
  end

  if set -qx WSL
    # make sure gpg-agent is running
    if type -q gpg-connect-agent.exe
      gpg-connect-agent.exe /bye >/dev/null 2>&1
    end

    # connect ssh to the windows ssh-agent
    if type -q weasel-pageant
      source (weasel-pageant -q -r -S fish | psub)
    end
  else
    # gpg-agent setup for local connections
    if type -q gpg-connect-agent; and not set -qx SSH_TTY; and not set -qx MOSH
      # launch gpg-agent with our pinentry-program (if not already running)
      gpg-agent --pinentry-program "$HOME/.local/bin/pinentry" --daemon 2>/dev/null

      # notify gpg-agent of our tty
      set -x GPG_TTY (tty)
      # notify gpg-agent's ssh compatibility of our tty
      gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

      # notify ssh of our gpg-agent socket
      set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    end
  end

  if set -qx WSL; or string match -q -r "(ttys|pts)" (tty)
    # start our main tmux session (on a pts)
    if type -q tmux; and not set -qx TMUX
      set -l session (prompt_hostname)
      if tmux has-session -t "$session" 2>/dev/null
        tmux new-session -t "$session"\; set-option destroy-unattached
      else
        tmux new-session -s "$session"
      end
    end
  else
    # start our X11 session (on tty1)
    if test "$XDG_VTNR" -eq 1
      exec startx
    end
  end
end

# vi:ft=fish:
