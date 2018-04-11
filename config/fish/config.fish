# shut up
set fish_greeting

if status --is-login
  # load system profile
  test -f /etc/profile
    and bass source /etc/profile

  # and our profile
  test -f ~/.profile
    and bass source ~/.profile

  # build the rest of our path
  path_prepend /usr/local/bin # homebrew
  path_prepend /usr/local/opt/coreutils/libexec/gnubin # homebrew coreutils
  path_prepend /usr/local/opt/findutils/libexec/gnubin # homebrew findutils
  path_prepend /usr/local/opt/gnu-sed/libexec/gnubin # homebrew sed
  path_prepend /usr/local/opt/gnu-tar/libexec/gnubin # homebrew tar
  path_prepend /usr/local/opt/gnu-getopt/bin # homebrew getopt
  path_prepend /usr/lib/ccache/bin # ccache
  path_prepend ~/bin # fresh
  path_prepend ~/.go/bin # go
  path_prepend ~/.cargo/bin # rust
  path_prepend ~/.pyenv/bin # pyenv
  path_prepend ~/.rbenv/bin # rbenv

  # notify systemd of path
  command -s systemctl >/dev/null 2>&1
    and systemctl --user import-environment PATH >/dev/null 2>&1
end

if status --is-interactive
  if status --is-login
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

  # enable 24bit color (if mosh is not detected)
  test -z "$MOSH"
    and set -g fish_term24bit 1

  # path/version managers
  command -s pyenv >/dev/null 2>&1
    and source (pyenv init -|psub)
    and source (pyenv virtualenv-init -|psub)
  command -s rbenv >/dev/null 2>&1
    and source (rbenv init -|psub)

  # fish plugins
  fundle plugin 'oh-my-fish/plugin-bang-bang'
  fundle plugin 'oh-my-fish/plugin-cd'
  fundle plugin 'fisherman/fzf'
  fundle plugin 'oh-my-fish/plugin-sudope'
  fundle plugin 'fisherman/z'
  fundle init

  # autostart actions (login, local, root shells only)
  if status --is-login; and test -z "$SSH_CLIENT"; and test -z "$MOSH"; and test -z "$TMUX"
    # exec X (on tty1 only)
    test -z "$DISPLAY" -a "$XDG_VTNR" = 1
      and exec startx

    # start tmux
    if command -s tmux >/dev/null 2>&1
      set -l session (hostname)
      tmux has-session -t $session
        and tmux new-session -t $session \; set-option destroy-unattached
        or tmux new-session -s $session
    end
  end
end

# vi:ft=fish:
