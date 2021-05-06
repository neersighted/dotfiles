is_ssh; and exit

set -x GPG_TTY $tty

if is_wsl
  if is_wsl1
    function is_listening -a path
      socat -u OPEN:/dev/null UNIX-CONNECT:$path &>/dev/null
    end
  else if is_wsl2
    function is_listening -a path
      set -q __netstat; or set -g __netstat (ss --family=unix --listening)

      string match -rq $path $__netstat
    end
  end

  # make sure the windows gpg-agent is up
  setsid -f gpg-connect-agent.exe /bye &>/dev/null

  # connect ssh to windows gpg-agent via wsl2-ssh-pageant
  set -x SSH_AUTH_SOCK $HOME/.ssh/ssh-agent.sock
  if not is_listening $SSH_AUTH_SOCK
    rm -f $SSH_AUTH_SOCK
    setsid -f socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:'wsl2-ssh-pageant.exe' &>/dev/null
  end

  # connect gpg to windows gpg-agent via wsl2-ssh-pageant
  if not is_listening $GNUPGHOME/S.gpg-agent
    rm -f $GNUPGHOME/S.gpg-agent
    setsid -f socat UNIX-LISTEN:$GNUPGHOME/S.gpg-agent,fork EXEC:'wsl2-ssh-pageant.exe --gpg S.gpg-agent' &>/dev/null
  end

  set -eg __netstat
  functions -e is_listening
else if not string match -rq 'S.gpg-agent.ssh$' $SSH_AUTH_SOCK
  # plumb ssh to gpg-agent
  set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end
