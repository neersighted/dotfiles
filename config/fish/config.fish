#
# Terminal
#

# Fix the keypad.
tput smkx

# Enable colors in ls.
source (dircolors -c ~/.dircolorsrc|psub)

# Enable color in less.
set -gx LESS -R
set -xU LESS_TERMCAP_mb (printf "\e[01;31m")      # begin blinking
set -xU LESS_TERMCAP_md (printf "\e[01;31m")      # begin bold
set -xU LESS_TERMCAP_me (printf "\e[0m")          # end mode
set -xU LESS_TERMCAP_se (printf "\e[0m")          # end standout-mode
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")   # begin standout-mode - info box
set -xU LESS_TERMCAP_ue (printf "\e[0m")          # end underline
set -xU LESS_TERMCAP_us (printf "\e[01;32m")      # begin underline

#
# Paths
#

# Set up $PATH.
set -gx PATH \
    $HOME/bin \
    /usr/local/{,s}bin \
    /usr/{,s}bin \
    /{,s}bin

# Ccache
if [ -d /usr/lib/ccache/bin ]
    set -gx PATH \
    /usr/lib/ccache/bin \
    $PATH
end

# rbenv
if [ -d $HOME/.rbenv ]
    set -gx PATH \
    $HOME/.rbenv/{bin,shims} \
    $PATH
end
# pyenv
if [ -d $HOME/.pyenv ]
    set -gx PATH \
    $HOME/.pyenv/{bin,shims} \
    $PATH
end
# ndenv
if [ -d $ndenv ]
    set -gx PATH \
    $HOME/.ndenv/{bin,shims} \
    $PATH
end
# perl
if [ -d /usr/bin/core_perl ]
   set -gx PATH \
   /usr/bin/{core,site,vendor}_perl \
   $PATH
end
# go
if type -fp go >/dev/null
   set -gx GOPATH $HOME/.go
   set -gx PATH \
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
set -gx PAGER less
set -gx EDITOR vim
set -gx BROWSER google-chrome

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
   source (envoy -p|sed -e 's/export/set -gx/' -e 's/=/ /'|psub)
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
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx
    end
end
