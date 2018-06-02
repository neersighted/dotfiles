function docker -d "docker client"
  if set -q WSL; and type -q npiperelay.exe; and not test -e /var/run/docker.sock
    sudo socat UNIX-LISTEN:/var/run/docker.sock,fork,group=docker,umask=007 EXEC:(which npiperelay.exe)" -ep -s //./pipe/docker_engine",nofork &
    disown %last
  end
  command docker $argv
end
