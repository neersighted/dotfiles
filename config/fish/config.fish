# interactive shells (attached to a keyboard)
if status --is-interactive
  # shut up
  set fish_greeting

  # programs
  set -x VISUAL nvim
  set -x EDITOR nvim
  set -x TERMINAL alacritty
  set -x LESS '-R'

  test (uname) = "Darwin"
    and set -x BROWSER open
    or set -x BROWSER firefox-nightly

  # fzf (global)
  set -x FZF_DEFAULT_COMMAND 'fd --type file'
  set -x FZF_DEFAULT_OPTS ''

  # fzf (plugin)
  set -g FZF_TMUX 1
  set -g FZF_COMPLETE 2
  set -g FZF_LEGACY_KEYBINDINGS 0
  set -g FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND
  set -g FZF_CD_COMMAND 'fd --type directory --follow'
  set -g FZF_CD_WITH_HIDDEN_COMMAND 'fd --type directory --follow --hidden --exclude .git'

  # libvirt
  set -x LIBVIRT_DEFAULT_URI qemu:///system

  # login actions (root shell only)
  if status --is-login
    if test (uname -r | cut -d- -f3) = "Microsoft"
      # connect ssh to the windows ssh-agent
      source (weasel-pageant -S fish|psub)

      # connect X applications to the windows X11 server
      set -x DISPLAY :0
    else
      # check for mosh
      set parent (ps -o comm= (ps -o ppid= %self | tr -d '[:space:]'))
      test $parent = "mosh-server"
        and set -x MOSH 1

      # notify gpg-agent of non-graphical sessions
      not set -q DISPLAY
        and set -x GPG_TTY (tty)

      # connect ssh to gpg-agent and inform gpg-agent of our TTY
      not set -q SSH_CLIENT; and not set -q MOSH
        and set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
        and gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
    end
  end

  # autostart actions (login, local, root shells only)
  if status --is-login
    and not set -q SSH_CLIENT; and not set -q MOSH; and not set -q TMUX

    # exec X (on tty1 only)
    test -z "$DISPLAY" -a "$XDG_VTNR" = 1
      and exec startx

    # start tmux (or attach if already running)
    if type -q tmux >/dev/null 2>&1
      set -l session (hostname)
      tmux has-session -t $session
        and tmux new-session -t $session \; set-option destroy-unattached
        or tmux new-session -s $session
    end
  end
end

# vi:ft=fish:
