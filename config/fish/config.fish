# interactive shells (attached to a keyboard)
if status --is-interactive
  # exports are inherited so there's no need to re-export them
  if status --is-login
    set -x VISUAL nvim
    set -x EDITOR nvim
    set -x TERMINAL alacritty
    set -x LESS '-R'
    test (uname) = "Darwin"
      and set -x BROWSER open
      or set -x BROWSER firefox-nightly

    # coreutils
    type -q dircolors
      and source (dircolors -c ~/.dircolors|psub)

    # libvirt
    set -x LIBVIRT_DEFAULT_URI qemu:///system

    # fzf (global)
    set -x FZF_DEFAULT_COMMAND 'fd --type file'
    set -x FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --no-bold"
  end

  # fzf (plugin)
  set -g FZF_TMUX 1
  set -g FZF_COMPLETE 2
  set -g FZF_LEGACY_KEYBINDINGS 0
  set -g FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND
  set -g FZF_CD_COMMAND 'fd --type directory --follow'
  set -g FZF_CD_WITH_HIDDEN_COMMAND 'fd --type directory --follow --hidden --exclude .git'

  # abbreviations (versioned here so they carry over automatically)
  if not set -q fish_abbr_version; or test $fish_abbr_version -lt 1
    abbr vim nvim # muscle memory
    set -U fish_abbr_version 1
  end

  if uname -r | grep -Fq "Microsoft"
    # connect ssh to the windows ssh-agent
    source (weasel-pageant -q -r -S fish | psub)

    # connect X applications to the windows X11 server
    set -x DISPLAY :0
  else
    # notify gpg-agent of non-graphical sessions
    status --is-login; and not set -q DISPLAY
      and set -x GPG_TTY (tty)

    # connect ssh to gpg-agent and inform gpg-agent of our TTY
    if not set -q SSH_CLIENT; and not set -q MOSH
      type -q gpgconf
        and set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
      type -q gpg-connect-agent
        and gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
    end
  end

  # autostart actions (login, local, root shells only)
  if status --is-login
    and not set -q SSH_CLIENT; and not set -q MOSH
    and not set -q TMUX

    # exec X (on tty1 only)
    test -z "$DISPLAY" -a "$XDG_VTNR" = 1
      and exec startx

    # start tmux (or attach if already running)
    if type -q tmux
      set -l session (hostname)
      tmux has-session -t $session
        and tmux new-session -t $session \; set-option destroy-unattached
        or tmux new-session -s $session
    end
  end
end

# vi:ft=fish:
