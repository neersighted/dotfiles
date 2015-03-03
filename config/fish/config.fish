#
# TTY
#

# Fix the keypad.
tput smkx

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
