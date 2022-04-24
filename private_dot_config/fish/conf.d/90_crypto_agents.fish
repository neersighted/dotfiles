is_ssh; and exit

if is_wsl1
  set -x SSH_AUTH_SOCK $USERPROFILE/wincrypt-wsl.sock
else if is_wsl2
  set -x SSH_AUTH_SOCK /mnt/wsl/wincrypt-hv.sock

  if not string match -rq $SSH_AUTH_SOCK (ss --family=unix --listening)
    rm -f $SSH_AUTH_SOCK
     setsid -f socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork VSOCK-CONNECT:2:0x22223333
  end
else
  set sockets $XDG_RUNTIME_DIR/var/run/yubikey-agent.sock
  is_macos; and set sockets -a (brew --prefix)/var/run/yubikey-agent.sock

  for sock in $sockets
    test -S $sock; and set -x SSH_AUTH_SOCK $sock
  end
end
