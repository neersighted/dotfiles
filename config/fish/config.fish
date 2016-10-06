# Environment

set --global --export LANG en_US.UTF-8

set --global --export XDG_DATA_HOME   $HOME/.local/share
set --global --export XDG_CACHE_HOME  $HOME/.cache
set --global --export XDG_CONFIG_HOME $HOME/.config

set --global --export TMP /tmp
set --global --export PATH \
  $HOME/bin \
  /usr/local/{,s}bin \
  /usr/{,s}bin \
  /{,s}bin

set --global --export EDITOR vim
set --global --export BROWSER google-chrome-stable
set --global --export LESS -R
set --global --export PINENTRY_USER_DATA gtk

test -d /usr/lib/ccache/bin; and set --global --export PATH /usr/lib/ccache/bin $PATH # arch
test -d /usr/local/opt/ccache/libexec; and set --global --export PATH /usr/local/opt/ccache/libexec $PATH # osx

test -d /usr/local/opt/coreutils/libexec/gnubin; and set --global --export PATH /usr/local/opt/coreutils/libexec/gnubin $PATH # osx

for xenv in rbenv pyenv ndenv
  test -d $HOME/.$xenv/shims; or mkdir -p $HOME/.$xenv/shims
  test -d $HOME/.$xenv/bin; and set --global --export PATH $HOME/.$xenv/{bin,shims} $PATH
end
test -d /usr/bin/core_perl; and set --global --export PATH /usr/bin/{core,site,vendor}_perl $PATH
type -fp go >/dev/null 2>&1; and set --global --export GOPATH $HOME/.go; and set --global --export PATH $GOPATH/bin $PATH
test -d $GOPATH; or mkdir -p $GOPATH

for dircolors in {,g}dircolors
  type -fp $dircolors >/dev/null 2>&1; and source (eval "$dircolors --c-shell ~/.dircolorsrc|psub")
end

set --global --export _JAVA_AWT_WM_NONREPARENTING 1 # dwm/java hacks

test -f $HOME/.config/fish/config.local.fish; and source $HOME/.config/fish/config.local.fish

# Startup

set -e fish_greeting # shut up

gpg-connect-agent /bye >/dev/null 2>&1
set --global --export GPG_TTY (tty)
set --global --export SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

if type -fp tmux >/dev/null 2>&1; and not [ $TMUX ]; and status --is-interactive
  if [ (uname) != "Darwin" ]; and not status --is-login; or [ (uname) = "Darwin" ]
    tmux has-session -t 0; and tmux new-session -t 0 \; set-option destroy-unattached; or tmux new-session -s 0
  end
end

tput smkx ^/dev/null # fix backspace in st
function fish_enable_keypad_transmit --on-event fish_postexec
    tput smkx ^/dev/null
end
function fish_disable_keypad_transmit --on-event fish_preexec
    tput rmkx ^/dev/null
end
