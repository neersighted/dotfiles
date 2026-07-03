is_ssh; and exit

set -l socket

if is_wsl
  set socket $XDG_RUNTIME_DIR/windows-ssh-proxy.sock
else if is_macos
  set socket $HOMEBREW_PREFIX/var/run/yubikey-agent.sock
else
  set socket $XDG_RUNTIME_DIR/var/run/yubikey-agent.sock
end

test -S $socket; and set -x SSH_AUTH_SOCK $socket
