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
if [ -d $HOME/.go ]
   set -gx GOPATH $HOME/.go
   set -gx PATH \
   $HOME/.go/bin \
   $PATH
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

# Check that we are an login shell.
if status --is-login
   # Load rbenv.
   source (rbenv init -|psub)
   # Load pyenv.
   source (pyenv init -|psub)

   # Run the GPG Agent.
   run_gpg-agent
end

# Check that we are an interactive shell.
if status --is-interactive
end

# Check that we are an not a login shell and are an interactive shell.
if not status --is-login; and not status --is-interactive
   # Run Tmux.
   if tmux has-session -t 0
      tmux attach-session -t 0
   else
      tmux new-session -s 0
   end
end

# Clear the startup message.
set -e fish_greeting
