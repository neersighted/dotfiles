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
set --global --export FZF_TMUX 1

test -d /usr/lib/ccache/bin; and set --global --export PATH /usr/lib/ccache/bin $PATH # arch
test -d /usr/local/opt/ccache/libexec; and set --global --export PATH /usr/local/opt/ccache/libexec $PATH # osx
test -d /usr/local/opt/coreutils/libexec/gnubin; and set --global --export PATH /usr/local/opt/coreutils/libexec/gnubin $PATH # osx
test -d /usr/bin/core_perl; and set --global --export PATH /usr/bin/{core,site,vendor}_perl $PATH

test -d $HOME/.rbenv/bin; and set --global --export PATH $HOME/.rbenv/bin $PATH; or rbenv-install
test -d $HOME/.pyenv/bin; and set --global --export PATH $HOME/.pyenv/bin $PATH; or pyenv-install
set --global --export GOPATH $HOME/.go; test -d $GOPATH/bin; or mkdir -p $GOPATH/bin
set --global --export PATH $GOPATH/bin $PATH

test -d $HOME/.fzf/bin; and set --global --export PATH $HOME/.fzf/bin $PATH

for dircolors in {,g}dircolors
  type -fp $dircolors >/dev/null 2>&1; and source (eval "$dircolors --c-shell ~/.dircolorsrc|psub")
end

set --global --export FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"' # fzf <3 rg

set --global --export _JAVA_AWT_WM_NONREPARENTING 1 # dwm/java hacks

test -f $HOME/.config/fish/config.local.fish; and source $HOME/.config/fish/config.local.fish

# Startup

set -e fish_greeting # shut up

if status --is-interactive
  set --global --export GPG_TTY (tty)
  set --global --export SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

  if test -z "$TMUX"; and test -z "$SSH_CLIENT"; and test -z "$SSH_TTY"
    if not status --is-login; or test (uname) = "Darwin"
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
end
