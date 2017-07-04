# Environment

set --global --export LANG en_US.UTF-8

set --global --export EDITOR nvim
set --global --export BROWSER google-chrome-stable
set --global --export LESS -R

set --global --export FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*" ^/dev/null' # fzf <3 rg
set --global --export FZF_DEFAULT_OPTS '--color fg:-1,bg:-1,hl:4,fg+:7,bg+:0,hl+:4 --color info:3,prompt:3,pointer:15,marker:15,spinner:3'

set --global --export FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND
set --global --export FZF_LEGACY_KEYBINDINGS 0
set --global --export FZF_TMUX 1

set --global --export GOPATH $HOME/.go

set --global --export _JAVA_AWT_WM_NONREPARENTING 1 # dwm/java hacks

set --global --export XDG_DATA_HOME   $HOME/.local/share
set --global --export XDG_CACHE_HOME  $HOME/.cache
set --global --export XDG_CONFIG_HOME $HOME/.config

set --global --export TMP /tmp
set --global --export PATH \
  $HOME/bin \
  /usr/local/{,s}bin \
  /usr/{,s}bin \
  /{,s}bin

# ccache
test -d /usr/lib/ccache/bin; and set --global --export PATH /usr/lib/ccache/bin $PATH
test -d /usr/local/opt/ccache/libexec; and set --global --export PATH /usr/local/opt/ccache/libexec $PATH

# gnu utilities (osx)
for util in {core,find}utils
  test -d /usr/local/opt/{$util}utils/libexec/gnubin; and set --global --export PATH /usr/local/opt/{$util}utils/libexec/gnubin $PATH
end

# languages
test -d $HOME/.rbenv/bin; and set --global --export PATH $HOME/.rbenv/bin $PATH
test -d $HOME/.pyenv/bin; and set --global --export PATH $HOME/.pyenv/bin $PATH
test -d $GOPATH/bin; set --global --export PATH $GOPATH/bin $PATH
test -d /usr/lib/jvm/default/bin; and set --global --export PATH /usr/lib/jvm/default/bin $PATH
test -d /usr/bin/core_perl; and set --global --export PATH /usr/bin/{core,site,vendor}_perl $PATH

for dircolors in {,g}dircolors
  type -fp $dircolors >/dev/null 2>&1; and source (eval "$dircolors --c-shell ~/.dircolorsrc|psub")
end

test -f $HOME/.config/fish/config.local.fish; and source $HOME/.config/fish/config.local.fish

# Plugins

fundle plugin 'fisherman/await'
fundle plugin 'fisherman/choices'
fundle plugin 'fisherman/get'
fundle plugin 'fisherman/getopts'
fundle plugin 'fisherman/get_file_age'
fundle plugin 'fisherman/last_job_id'
fundle plugin 'fisherman/menu'

fundle plugin 'fisherman/anicode'
fundle plugin 'oh-my-fish/plugin-bang-bang'
fundle plugin 'edc/bass'
fundle plugin 'tuvistavie/fish-completion-helpers'
fundle plugin 'fisherman/docker-completion'
fundle plugin 'fisherman/fnm'
fundle plugin 'fisherman/fzf'
fundle plugin 'oh-my-fish/plugin-gi'
fundle plugin 'oh-my-fish/plugin-license'
fundle plugin 'fisherman/pyenv'
fundle plugin 'fisherman/rbenv'
fundle plugin 'fisherman/shark'
fundle plugin 'fisherman/spin'
fundle plugin 'oh-my-fish/plugin-sudope'
fundle plugin 'oh-my-fish/plugin-thefuck'
fundle plugin 'fisherman/z'

fundle init

# Startup

set fish_greeting # shut up

if [ (ps -o comm= (ps -o ppid= %self | tr -d '[:space:]')) = "mosh-server" ]
  set --global --export MOSH 1
end

if status --is-interactive
  set --global --export GPG_TTY (tty)
  set --global --export SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

  if test -z "$TMUX"; and test -z "$SSH_CLIENT"; and test -z "$SSH_TTY"
    if not status --is-login; or test (uname) = "Darwin"
      tmux has-session -t 0; and tmux new-session -t 0 \; set-option destroy-unattached; or tmux new-session -s 0
    end
  end

  if test -z "$MOSH" # enable 24bit color
    set --global fish_term24bit 1
  end

  tput smkx ^/dev/null # fix backspace in st
  function fish_enable_keypad_transmit --on-event fish_postexec
    tput smkx ^/dev/null
  end
  function fish_disable_keypad_transmit --on-event fish_preexec
    tput rmkx ^/dev/null
  end
end
