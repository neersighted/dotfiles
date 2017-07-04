if status --is-login
  # Environment

  # bootstrap fenv
  set fish_function_path ~/.fresh/build/vendor/fenv $fish_function_path
  
  # load profile
  fenv source /etc/profile

  # load dircolors
  fenv eval `dircolors ~/.dircolorsrc`

  # defaults
  set -x EDITOR nvim
  set -x BROWSER google-chrome-stable
  set -x LESS -R

  # xdg
  set -x XDG_CONFIG_HOME $HOME/.config
  set -x XDG_DATA_HOME $HOME/.local/share
  set -x XDG_CACHE_HOME $HOME/.cache

  # fzf
  set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*" ^/dev/null' # fzf <3 rg
  set -x FZF_DEFAULT_OPTS '--color fg:-1,bg:-1,hl:4,fg+:7,bg+:0,hl+:4 --color info:3,prompt:3,pointer:15,marker:15,spinner:3'
  set -x FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND
  set -x FZF_LEGACY_KEYBINDINGS 0
  set -x FZF_TMUX 1

  # go
  set -x GOPATH $HOME/.go

  # java
  set -x _JAVA_AWT_WM_NONREPARENTING 1 # dwm/java hacks

  # ccache
  path_prepend /usr/lib/ccache/bin
  path_prepend /usr/local/opt/ccache/libexec

  # gnu utilities (osx)
  for util in {core,find}utils
    path_prepend /usr/local/opt/{$util}utils/libexec/gnubin
  end

  # languages
  path_prepend ~/.rbenv/bin
  path_prepend ~/.pyenv/bin
  path_prepend $GOPATH/bin

  # fresh
  path_prepend ~/bin
end

if status --is-interactive
  # Plugins

  # deps
  fundle plugin 'fisherman/await'
  fundle plugin 'fisherman/choices'
  fundle plugin 'tuvistavie/fish-completion-helpers'
  fundle plugin 'fisherman/get'
  fundle plugin 'fisherman/getopts'
  fundle plugin 'fisherman/get_file_age'
  fundle plugin 'fisherman/last_job_id'
  fundle plugin 'fisherman/menu'

  # interactive plugins
  fundle plugin 'fisherman/anicode'
  fundle plugin 'oh-my-fish/plugin-bang-bang'
  fundle plugin 'edc/bass'
  fundle plugin 'fisherman/docker-completion'
  fundle plugin 'fisherman/fnm'
  fundle plugin 'fisherman/fzf'
  fundle plugin 'oh-my-fish/plugin-gi'
  fundle plugin 'oh-my-fish/plugin-license'
  fundle plugin 'fisherman/pyenv'
  fundle plugin 'fisherman/rbenv'
  fundle plugin 'oh-my-fish/plugin-sudope'
  fundle plugin 'fisherman/z'

  fundle init

  # Startup

  # shut up
  set fish_greeting

  # check for mosh
  if [ (ps -o comm= (ps -o ppid= %self | tr -d '[:space:]')) = "mosh-server" ]
    set -x MOSH 1
  end

  # enable gpg ssh support
  set -x GPG_TTY (tty)
  set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  # fix pinentry
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

  # enable 24bit color
  if test -z "$MOSH"
    set --global fish_term24bit 1
  end

  # fix backspace in st
  tput smkx ^/dev/null
  function fish_enable_keypad_transmit --on-event fish_postexec
    tput smkx ^/dev/null
  end
  function fish_disable_keypad_transmit --on-event fish_preexec
    tput rmkx ^/dev/null
  end
end

# load local configuration if available
test -f $HOME/.config/fish/config.local.fish
and source $HOME/.config/fish/config.local.fish

# autostart tmux when logged in locally
if status --is-login; and status --is-interactive; and test -z "$TMUX"; and test -z "$SSH_CLIENT"
  tmux has-session -t 0; and tmux new-session -t 0 \; set-option destroy-unattached; or tmux new-session -s 0
end

# vim:ft=fish
