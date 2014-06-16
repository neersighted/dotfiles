#
# Paths
#

# Set up $PATH.
set -x PATH \
    $HOME/bin \
    /usr/local/{,s}bin \
    /usr/{,s}bin \
    /{,s}bin

# Ccache
if [ -d /usr/lib/ccache/bin ]
    set -x PATH \
    /usr/lib/ccache/bin \
    $PATH
end

# rbenv
if [ -d $HOME/.rbenv ]
    set -x PATH \
    $HOME/.rbenv/{bin,shims} \
    $PATH
end
# pyenv
if [ -d $HOME/.pyenv ]
    set -x PATH \
    $HOME/.pyenv/{bin,shims} \
    $PATH
end

#
# Options
#

# Set programs.
set -x EDITOR vim
set -x PAGER most
set -x BROWSER google-chrome

#
# Startup
#

# Check that we are an login shell.
if status --is-login
   # Clear the startup message.
   set fish_greeting

   # Run CDM if we're not in it...
   if not set -q CDM
      set -x CDM 1
      exec cdm
   end
end

# Check that we are an interactive shell.
if status --is-interactive
   # Run Tmux.
   if tmux has-session -t main
      tmux attach-session -t main
   else
      tmux new-session -s main
   end
end
