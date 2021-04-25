set tty (tty)

function is_macos
  set -q uname; or set -g uname (uname)
  test $uname = 'Darwin'
end

function is_linux
  set -q uname; or set -g uname (uname)
  test $uname = 'Linux'
end

function is_freebsd
  set -q uname; or set -g uname (uname)
  test $uname = 'FreeBSD'
end

function is_wsl
  set -q WSLENV
end

function is_wsl1
  set -q WSLENV; and not set -q WSL_INTEROP
end

function is_wsl2
  set -q WSLENV; and set -q WSL_INTEROP
end

function is_docker
  test -f /.dockerenv
end

function is_ssh
  set -q SSH_CONNECTION
end

function is_tmux
  set -q TMUX
end

function is_iterm
  test "$TERM_PROGRAM" = 'iTerm.app'
end

function is_nvim
  set -q NVIM_LISTEN_ADDRESS
end

function is_vscode
  test "$TERM_PROGRAM" = 'vscode'
end

function is_editor
  is_nvim; or is_vscode
end
