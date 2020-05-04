set -g tty (tty)

function is_macos
  if not set -q MACOS
    not test (uname) = 'Darwin'
    set -g MACOS $status
  end
  test $MACOS -eq 1
end

function is_linux
  if not set -q LINUX
    not test (uname) = 'Linux'
    set -g LINUX $status
  end
  test $LINUX -eq 1
end

function is_freebsd
  if not set -q FREEBSD
    not test (uname) = 'FreeBSD'
    set -g FREEBSD $status
  end
  test $FREEBSD -eq 1
end

function is_wsl
  set -q WSLENV
end

function is_wsl1
  is_wsl; and not set -q WSL_INTEROP
end

function is_wsl2
  is_wsl; and set -q WSL_INTEROP
end

function is_ssh
  set -q SSH_CONNECTION
end

function is_tmux
  set -q TMUX
end

function is_nvim
  set -q NVIM_LISTEN_ADDRESS
end

function is_vscode
  test "$TERM_PROGRAM" = 'vscode'
end

function is_iterm
  test "$TERM_PROGRAM" = 'iTerm.app'
end
