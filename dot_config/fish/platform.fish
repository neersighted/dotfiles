set -g tty (tty)

function is_macos
  if not set -q is_macos
    not test (uname) = 'Darwin'
    set -g is_macos $status
  end
  test $is_macos -eq 1
end

function is_linux
  if not set -q is_linux
    not test (uname) = 'Linux'
    set -g is_linux $status
  end
  test $is_linux -eq 1
end

function is_freebsd
  if not set -q is_freebsd
    not test (uname) = 'FreeBSD'
    set -g is_freebsd $status
  end
  test $is_freebsd -eq 1
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
