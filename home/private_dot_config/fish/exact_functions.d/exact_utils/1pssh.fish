function 1pssh -d 'ssh with 1Password'
  set -a options 'c/command='
  argparse -i $options -- $argv; or return

  if is_macos
    set -fx SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
  else
    set -fx SSH_AUTH_SOCK ~/.1password/agent.sock
  end

  set command "ssh"
  if set -q _flag_c
    set command "ssh-$_flag_c"
  end

  $command $argv
end
