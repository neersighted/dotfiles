# shut up
set fish_greeting

# bootstrap fenv
set fish_function_path ~/.fresh/build/vendor/fenv $fish_function_path

if status --is-login
  # load profile
  fenv source /etc/profile

  # load dircolors
  fenv eval `dircolors ~/.dircolorsrc`

  # configure less
  set -x LESS '-R'

  # configure fzf
  set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*" ^/dev/null' # fzf <3 rg
  set -x FZF_DEFAULT_OPTS '--color fg:-1,bg:-1,hl:4,fg+:7,bg+:0,hl+:4 --color info:3,prompt:3,pointer:15,marker:15,spinner:3'
  set -x FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND
  set -x FZF_LEGACY_KEYBINDINGS 0
  set -x FZF_TMUX 1

  # configure go
  set -x GOPATH $HOME/.go

  # check for mosh
  if [ (ps -o comm= (ps -o ppid= %self | tr -d '[:space:]')) = "mosh-server" ]
    set -x MOSH 1
  end

  # notify gpg-agent of non-graphical sessions
  test -z "$DISPLAY"
  and set -x GPG_TTY (tty)

  # connect ssh to gpg-agent
  set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

  # set path
  path_prepend /usr/lib/ccache/bin # ccache
  path_prepend ~/bin # fresh
  path_prepend $GOPATH/bin # go
  path_prepend ~/.pyenv/bin # pyenv
  path_prepend ~/.rbenv/bin # rbenv
end

# load local configuration if available
test -f $HOME/.config/fish/config.local.fish
and source $HOME/.config/fish/config.local.fish

if status --is-interactive
  # enable 24bit color (if mosh is not detected)
  if test -z "$MOSH"
    set -g fish_term24bit 1
  end

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
  fundle plugin 'fisherman/fnm'
  fundle plugin 'fisherman/fzf'
  fundle plugin 'oh-my-fish/plugin-gi'
  fundle plugin 'oh-my-fish/plugin-license'
  fundle plugin 'oh-my-fish/plugin-sudope'
  fundle plugin 'fisherman/z'

  # conditional plugins (only if installed)
  command -sq pyenv; and fundle plugin 'fisherman/pyenv'
  command -sq rbenv; and fundle plugin 'fisherman/rbenv'

  # load plugins
  fundle init

  # dedupliate $PATH (just in case)
  path_dedupe

  # local actions (no ssh)
  if test -z "$SSH_CLIENT"; and test -z "$MOSH"
    # notify gpg-agent of our login
    gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

    # notify systemd of path
    systemctl --user import-environment PATH

    # autostart tmux (for login shells only)
    if status --is-login; and test -z "$TMUX"
      tmux has-session -t 0
      and tmux new-session -t 0 \; set-option destroy-unattached
      or tmux new-session -s 0
    end
  end
end

# vim:ft=fish
