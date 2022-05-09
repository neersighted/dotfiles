function gssh -d 'ssh with GPG keys'
  set -a options 'c/command='
  argparse -i $options -- $argv; or return

  set -gx GPG_TTY (tty) # update GPG tty
  gpgconf --launch gpg-agent # start GPG agent
  gpg-connect-agent UPDATESTARTUPTTY /bye >/dev/null # update GPG agent ssh-askpass TTY

  set -lx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)

  set command "ssh"
  if set -q _flag_c
    set command "ssh-$_flag_c"
  end

  $command $argv
end
