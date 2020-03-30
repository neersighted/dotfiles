function __gpg-agent_auto_start -d 'manage gpg-agent startup'
  if is_wsl
    # make sure gpg-agent is up
    gpg-connect-agent.exe /bye &>/dev/null
    # connect ssh to windows gpg-agent via weasel-pageant
    set -q SSH_AUTH_SOCK; or weasel-pageant -qrb -a $HOME/.ssh/weasel-pageant.sock -c | source
    # connect gpg to windows gpg-agent via socat/npiperelay
    test -e $GNUPGHOME/S.gpg-agent; or wsl-gpg-relay
  else if not string match -rq 'S.gpg-agent.ssh$' $SSH_AUTH_SOCK
    # connect ssh to gpg-agent
    set -x SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
  end
end
