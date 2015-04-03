#
# Terminal
#

# Fix the keypad.
tput smkx

# Enable colors in ls.
source (dircolors --c-shell ~/.dircolorsrc|psub)

# Enable color in less.
set --global --export LESS -R
set -xU LESS_TERMCAP_mb (printf "\e[01;31m")      # begin blinking
set -xU LESS_TERMCAP_md (printf "\e[01;31m")      # begin bold
set -xU LESS_TERMCAP_me (printf "\e[0m")          # end mode
set -xU LESS_TERMCAP_se (printf "\e[0m")          # end standout-mode
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")   # begin standout-mode - info box
set -xU LESS_TERMCAP_ue (printf "\e[0m")          # end underline
set -xU LESS_TERMCAP_us (printf "\e[01;32m")      # begin underline

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

# Ccache
if [ -d /usr/lib/ccache/bin ]
    set --global --export PATH \
    /usr/lib/ccache/bin \
    $PATH
end

# rbenv
if [ -d $HOME/.rbenv ]
    set --global --export PATH \
    $HOME/.rbenv/{bin,shims} \
    $PATH
end
# pyenv
if [ -d $HOME/.pyenv ]
    set --global --export PATH \
    $HOME/.pyenv/{bin,shims} \
    $PATH
end
# ndenv
if [ -d $ndenv ]
    set --global --export PATH \
    $HOME/.ndenv/{bin,shims} \
    $PATH
end
# perl
if [ -d /usr/bin/core_perl ]
   set --global --export PATH \
   /usr/bin/{core,site,vendor}_perl \
   $PATH
end
# go
if type -fp go >/dev/null
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
set --global --export GREPER ag
set --global --export EXPLORER spacefm
set --global --export MEDIA_PLAYER mpv
set --global --export IMAGE_VIEWER feh
set --global --export BROWSER google-chrome
set --global --export MAILER thunderbird
set --global --export TERMINAL st

#
# Startup
#

# Load rbenv.
if type -fp rbenv >/dev/null
   source (rbenv init -|psub)
end
# Load pyenv.
if type -fp pyenv >/dev/null
   source (pyenv init -|psub)
   source (pyenv virtualenv-init -|psub)
end
# Load ndenv.
if type -fp ndenv >/dev/null
   #source (ndenv init -|psub)
end

# Connect to envoy.
if type -fp envoy >/dev/null
   envoy -t gpg-agent
   source (envoy -p|sed -e 's/export/set --global --export/' -e 's/=/ /'|psub)
end

# Check that we are an not a login shell and are an interactive shell.
if not status --is-login; and not status --is-interactive
   # Run Tmux.
   if type -fp tmux >/dev/null
      if tmux has-session -t 0
         tmux new -t 0
      else
         tmux new-session -s 0
      end
   end
end

# Clear the startup message.
set -e fish_greeting

if [ -f $HOME/.config/fish/config.local.fish ]
   source $HOME/.config/fish/config.local.fish
end

# Start X at login on VT 1.
#$if status --is-login
#$if test -z "$DISPLAY" -a $XDG_VTNR = 1
#$exec startx
#$end
#$end
