is_ssh; and exit

set -x GPG_TTY $tty

if is_wsl
  set -x SSH_AUTH_SOCK $HOME/.ssh/ssh-agent.sock

  # connect ssh to windows gpg-agent via wsl2-ssh-pageant
  if not ss -a | string match -rq $SSH_AUTH_SOCK
    rm -f $SSH_AUTH_SOCK
    setsid -f socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:'wsl2-ssh-pageant.exe' &>/dev/null
  end

  # connect gpg to windows gpg-agent via wsl2-ssh-pageant
  if not ss -a | string match -rq $GNUPGHOME/S.gpg-agent
    rm -f $GNUPGHOME/S.gpg-agent
    setsid -f socat UNIX-LISTEN:$GNUPGHOME/S.gpg-agent,fork EXEC:'wsl2-ssh-pageant.exe --gpg S.gpg-agent' &>/dev/null
  end
else if not string match -rq 'S.gpg-agent.ssh$' $SSH_AUTH_SOCK
  # plumb ssh to gpg-agent
  set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end
