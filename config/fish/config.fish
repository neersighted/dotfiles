if status --is-interactive
  # use 24bit color in non-basic terminals
  if test "$TERM" != "xterm"; and test "$TERM" != "linux"
    set -g fish_term24bit 1
  end

  # first-time universal variable provisioning
  # this allows variables to be overridden locally with set -U
  # set -Ue fish_initialized to reset
  if not set -q fish_initialized;
    source "$HOME/.config/fish/abbreviations.fish"
    source "$HOME/.config/fish/appearance.fish"

    # shell environment
    set -Ux VISUAL nvim
    set -Ux EDITOR nvim
    set -Ux PAGER less
    set -Ux MANPAGER 'nvim -c "set ft=man" -'
    set -Ux LESS '--RAW-CONTROL-CHARS --tabs=4'
    set -Ux TERMINAL alacritty
    if test (uname) = "Darwin"
      set -Ux BROWSER open
    else
      if type -q firefox-nightly
        set -Ux BROWSER firefox-nightly
      else if type -q firefox
        set -Ux BROWSER firefox
      else if type -q google-chrome
        set -Ux BROWSER google-chrome
      end
    end

    # libvirt
    set -Ux LIBVIRT_DEFAULT_URI qemu:///system

    # fzf (core)
    set -Ux FZF_DEFAULT_COMMAND 'fd --type file'
    set -Ux FZF_DEFAULT_OPTS '--no-bold'
    if set -q fish_term24bit
      set -Ux FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --color=fg:#839496,bg:#002b36,hl:#eee8d5,fg+:#839496,bg+:#073642,hl+:#d33682 --color=info:#2aa198,prompt:#839496,pointer:#fdf6e3,marker:#fdf6e3,spinner:#2aa198"
    else
      set -Ux FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --color=fg:12,bg:8,hl:7,fg+:12,bg+:0,hl+:5 --color=info:6,prompt:12,pointer:15,marker:15,spinner:6"
    end

    # fzf (plugin)
    set -U FZF_TMUX 1
    set -U FZF_TMUX_HEIGHT 25%
    set -U FZF_COMPLETE 2
    set -U FZF_LEGACY_KEYBINDINGS 0
    set -U FZF_FIND_FILE_COMMAND $FZF_DEFAULT_COMMAND
    set -U FZF_CD_COMMAND 'fd --type directory --follow'
    set -U FZF_CD_WITH_HIDDEN_COMMAND 'fd --type directory --follow --hidden --exclude .git'

    set -U fish_initialized
  end

  # per-shell setup logic
  if set -q WSL
    # connect ssh to the windows ssh-agent
    if type -q weasel-pageant
      source (weasel-pageant -q -r -S fish | psub)
    end

    # make sure gpg-agent is running
    if type -q gpg-connect-agent.exe
      gpg-connect-agent.exe /bye >/dev/null 2>&1
    end

    # connect X applications to the windows X11 server
    set -x DISPLAY :0
  else
    # gpg-agent setup for local connections
    if type -q gpg-connect-agent; and not set -q SSH_TTY; and not set -q MOSH
      # launch gpg-agent with our pinentry-program (if not already running)
      gpg-agent --pinentry-program "$HOME/.local/bin/pinentry" --daemon 2>/dev/null

      # notify gpg-agent of our tty
      set -x GPG_TTY (tty)
      # notify gpg-agent's ssh compatibility of our tty
      gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
      # notify ssh of our gpg-agent socket
      set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    end
  end

  if set -q WSL; or string match -q -r "(ttys|pts)" (tty)
    # start our main tmux session (on a pts)
    if type -q tmux; and not set -q TMUX
      set -l session (prompt_hostname)
      if tmux has-session -t "$session" 2>/dev/null
        tmux new-session -t "$session"\; set-option destroy-unattached
      else
        tmux new-session -s "$session"
      end
    end
  else
    # start our X11 session (on tty1)
    if test "$XDG_VTNR" -eq 1
      exec startx
    end
  end
end

# vi:ft=fish:
