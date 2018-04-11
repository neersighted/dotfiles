# interactive shells (attached to a keyboard)
if status --is-interactive
  # shut up
  set fish_greeting

  # login actions (root shell only)
  if status --is-login
    # load our profile (environmental variables)
    test -f ~/.profile
      and bass source ~/.profile

    # ...and the local version (which probably does not exist)
    test -f ~/.profile.local
      and bass source ~/.profile.local

    if test (uname -r|cut -d- -f3) = "Microsoft"
      # connect ssh to the windows ssh-agent
      source (weasel-pageant -S fish|psub)

      # connect X applications to the windows X11 server
      set -x DISPLAY :0
    else
      # check for mosh
      set parent (ps -o comm= (ps -o ppid= %self | tr -d '[:space:]'))
      test $parent = "mosh-server"
        and set -x MOSH 1

      # notify gpg-agent of non-graphical sessions
      test -z "$DISPLAY"
        and set -x GPG_TTY (tty)

      # connect ssh to gpg-agent and inform gpg-agent of our TTY
      test -z "$SSH_CLIENT"; and test -z "$MOSH"
        and set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
        and gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
    end
  end

  # version managers (post-init)
  test -d ~/.pyenv/plugins/pyenv-virtualenv
    and source (pyenv virtualenv-init -|psub)
  test -d ~/.nvm
    and set -g nvm_alias_output ~/bin

  # enable 24bit color (if mosh is not detected)
  test -z "$MOSH"
    and set -g fish_term24bit 1

  # autostart actions (login, local, root shells only)
  if status --is-login
    and test -z "$SSH_CLIENT"; and test -z "$MOSH"; and test -z "$TMUX"

    # exec X (on tty1 only)
    test -z "$DISPLAY" -a "$XDG_VTNR" = 1
      and exec startx

    # start tmux (or attach if already running)
    if command -s tmux >/dev/null 2>&1
      set -l session (hostname)
      tmux has-session -t $session
        and tmux new-session -t $session \; set-option destroy-unattached
        or tmux new-session -s $session
    end
  end
end

# vi:ft=fish:
