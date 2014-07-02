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

#
# Options
#

# Set programs.
set -gx PAGER less
set -gx EDITOR vim
set -gx BROWSER google-chrome
set -gx PINENTRY /usr/bin/pinentry-curses

#
# Startup
#

# Check that we are an login shell.
if status --is-login
   # Clear the startup message.
   set -e fish_greeting

   # Run CDM if we're not in it...
   if not set -q CDM
      set -gx CDM 1
      exec cdm
   end
end

# Check that we are an interactive shell.
if status --is-interactive
   # Load rbenv.
   source (rbenv init -|psub)
   # Load pyenv.
   source (pyenv init -|psub)

   # Run the GPG Agent.
   run_gpg-agent

   # Run Tmux.
   if tmux has-session -t main
      tmux attach-session -t main
   else
      tmux new-session -s main
   end
end
