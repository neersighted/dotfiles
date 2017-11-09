# shut up
set fish_greeting

# bootstrap fenv
set fish_function_path ~/.fresh/build/vendor/fenv $fish_function_path

if status --is-login
  # load system profile
  test -f /etc/profile
    and fenv source /etc/profile

  # and our profile
  test -f ~/.profile
    and fenv source ~/.profile
end

if status --is-interactive
  if status --is-login
    # check for mosh
    set parent (ps -o comm= (ps -o ppid= %self | tr -d '[:space:]'))
    test $parent = "mosh-server"
      and set -x MOSH 1

    # notify gpg-agent of non-graphical sessions
    test -z "$DISPLAY"
      and set -x GPG_TTY (tty)
  end

  # enable iterm2 support
  test (uname) = "Darwin"; and test -d ~/.iterm2
    and set -x ITERM2 1
    and source $XDG_CONFIG_HOME/fish/iterm2_shell_integration.fish
  iterm2_touchbar

  # enable 24bit color (if mosh is not detected)
  test -z "$MOSH"
    and set -g fish_term24bit 1

  # connect ssh to gpg-agent
  test -z "$SSH_AUTH_SOCK"
    and set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

  # set path
  path_prepend /usr/local/bin # homebrew
  path_prepend /usr/lib/ccache/bin # ccache
  path_prepend ~/bin # fresh
  path_prepend ~/.iterm2 # iterm2
  path_prepend ~/.go/bin # go
  path_prepend ~/.pyenv/bin # pyenv
  path_prepend ~/.rbenv/bin # rbenv

  # list plugin dependencies
  fundle plugin 'fisherman/await'
  fundle plugin 'fisherman/choices'
  fundle plugin 'tuvistavie/fish-completion-helpers'
  fundle plugin 'fisherman/get'
  fundle plugin 'fisherman/getopts'
  fundle plugin 'fisherman/get_file_age'
  fundle plugin 'fisherman/last_job_id'
  fundle plugin 'fisherman/menu'

  # list plugins
  fundle plugin 'fisherman/anicode'
  fundle plugin 'oh-my-fish/plugin-bang-bang'
  fundle plugin 'edc/bass'
  fundle plugin 'fisherman/docker-completion'
  fundle plugin 'fisherman/fzf'
  fundle plugin 'oh-my-fish/plugin-gi'
  fundle plugin 'oh-my-fish/plugin-license'
  fundle plugin 'oh-my-fish/plugin-sudope'
  fundle plugin 'fisherman/z'

  # conditional plugins (only if installed)
  command -s pyenv >/dev/null 2>&1
    and fundle plugin 'fisherman/pyenv'
  command -s rbenv >/dev/null 2>&1
    and fundle plugin 'fisherman/rbenv'

  # load plugins
  fundle init

  # local login actions (no ssh)
  if status --is-login; and test -z "$SSH_CLIENT"; and test -z "$MOSH"
    # notify gpg-agent of our login
    gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

    # notify systemd of path
    command -s systemctl >/dev/null 2>&1; and systemctl --user import-environment PATH >/dev/null 2>&1


    # autostart X (on tty1 only)
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx
    end

    # autostart tmux (for login shells only)
    if test -z "$TMUX"; and command -s tmux >/dev/null 2>&1
      set -l session (hostname)
      tmux has-session -t $session
        and tmux new-session -t $session \; set-option destroy-unattached
        or tmux new-session -s $session
    end
  end
end

# vim:ft=fish
