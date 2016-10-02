#
# Terminal
#

# Fix the keypad.
tput smkx

# Enable colors in ls.
if type -fp dircolors >/dev/null 2>&1
  source (dircolors --c-shell ~/.dircolorsrc|psub)
else if type -fp gdircolors >/dev/null 2>&1
  source (gdircolors --c-shell ~/.dircolorsrc|psub)
end

# Enable color in less.
set --global --export LESS -R
set --global --export LESS_TERMCAP_mb (printf "\e[01;31m")      # begin blinking
set --global --export LESS_TERMCAP_md (printf "\e[01;31m")      # begin bold
set --global --export LESS_TERMCAP_me (printf "\e[0m")          # end mode
set --global --export LESS_TERMCAP_se (printf "\e[0m")          # end standout-mode
set --global --export LESS_TERMCAP_so (printf "\e[01;44;33m")   # begin standout-mode - info box
set --global --export LESS_TERMCAP_ue (printf "\e[0m")          # end underline
set --global --export LESS_TERMCAP_us (printf "\e[01;32m")      # begin underline

# Fix Java windows in DWM.
set --global --export _JAVA_AWT_WM_NONREPARENTING 1

#
# Environment
#

# Locale/language.
set --global --export LANG en_US.UTF-8

# XDG.
set --global --export XDG_DATA_HOME   $HOME/.local/share
set --global --export XDG_CACHE_HOME  $HOME/.cache
set --global --export XDG_CONFIG_HOME $HOME/.config

# Tmp.
set --global --export TMP /tmp

# Path.
set --global --export PATH \
    $HOME/bin \
    /usr/local/{,s}bin \
    /usr/{,s}bin \
    /{,s}bin

# coreutils
if test -d /usr/local/opt/coreutils/libexec/gnubin
    set --global --export PATH \
    /usr/local/opt/coreutils/libexec/gnubin \
    $PATH
end

# ccache
if test -d /usr/lib/ccache/bin
    set --global --export PATH \
    /usr/lib/ccache/bin \
    $PATH
else if test -d /usr/local/opt/ccache/libexec
    set --global --export PATH \
    /usr/local/opt/ccache/libexec \
    $PATH
end

# rbenv
if test -d $HOME/.rbenv/bin
    set --global --export PATH \
    $HOME/.rbenv/{bin,shims} \
    $PATH
end
# pyenv
if test -d $HOME/.pyenv/bin
    set --global --export PATH \
    $HOME/.pyenv/{bin,shims} \
    $PATH
end
# ndenv
if test -d $HOME/.ndenv/bin
    set --global --export PATH \
    $HOME/.ndenv/{bin,shims} \
    $PATH
end
# perl
if test -d /usr/bin/core_perl
   set --global --export PATH \
   /usr/bin/{core,site,vendor}_perl \
   $PATH
end
# go
if type -fp go >/dev/null 2>&1
   set --global --export GOPATH $HOME/.go
   set --global --export PATH \
   $HOME/.go/bin \
   $PATH

   if [ ! -d $HOME/.go ]
      mkdir -p $HOME/.go
   end
end

#
# Options
#

# Set programs.
set --global --export EDITOR vim
set --global --export PAGER less
set --global --export GREPER rg
set --global --export EXPLORER spacefm
set --global --export MEDIA_PLAYER mpv
set --global --export IMAGE_VIEWER feh
set --global --export BROWSER google-chrome
set --global --export TERMINAL st

#
# Startup
#

# Load rbenv.
if type -fp rbenv >/dev/null 2>&1
   source (rbenv init -|psub)
end
# Load pyenv.
if type -fp pyenv >/dev/null 2>&1
   source (pyenv init -|psub)
   source (pyenv virtualenv-init -|psub)
end
# Load ndenv.
if type -fp ndenv >/dev/null 2>&1
   #source (ndenv init -|psub)
end

# Set agent variables.
set --export GPG_TTY (tty)
if test -e /run/user/(id -u)/gnupg/S.gpg-agent.ssh
  set --global --export SSH_AUTH_SOCK /run/user/(id -u)/gnupg/S.gpg-agent.ssh
else
  set --global --export SSH_AUTH_SOCK $HOME/.gnupg/S.gpg-agent.ssh
end
# Ensure the agent is running.
gpg-connect-agent updatestartuptty /bye >/dev/null

# Check that we are a login shell and are an interactive shell.
if type -fp tmux >/dev/null 2>&1
  if not [ $TMUX ]; and status --is-interactive
    if [ (uname) != "Darwin" ]; and not status --is-login; or [ (uname) = "Darwin" ]
      # Run Tmux.
      if tmux has-session -t 0
        tmux new-session -t 0 \; set-option destroy-unattached
      else
        tmux new-session -s 0
      end
    end
  end
end

# Clear the startup message.
set -e fish_greeting

if test -f $HOME/.config/fish/config.local.fish
   source $HOME/.config/fish/config.local.fish
end

# Start X at login on VT 1.
#$if status --is-login
#$if test -z "$DISPLAY" -a $XDG_VTNR = 1
#$exec startx
#$end
#$end
