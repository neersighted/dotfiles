function macos?
  if not set -q MACOS
    not test (uname) = 'Darwin'
    set -g MACOS $status
  end
  test $MACOS -eq 1
end

function linux?
  if not set -q LINUX
    not test (uname) = 'Linux'
    set -g LINUX $status
  end
  test $LINUX -eq 1
end

function freebsd?
  if not set -q FREEBSD
    not test (uname) = 'FreeBSD'
    set -g FREEBSD $status
  end
  test $FREEBSD -eq 1
end

function wsl?
  if not set -q WSL
    not set -q WSLENV
    set -g WSL $status
  end
  test $WSL -eq 1
end

function ssh?
  set -q SSH_CONNECTION
end

function tmux?
  set -q TMUX
end

function nvim?
  if not set -q NVIM
    not set -q NVIM_LISTEN_ADDRESS
    set -g NVIM $status
  end
  test $NVIM -eq 1
end
