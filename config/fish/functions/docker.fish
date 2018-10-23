function docker -d 'docker client'
  if set -qg WSL; and not test -e /var/run/docker.sock; and command -sq npiperelay.exe
    sudo sh -c "socat UNIX-LISTEN:/var/run/docker.sock,fork,group=docker,umask=007 EXEC:\""(command -s npiperelay.exe)" -ep -s //./pipe/docker_engine\",nofork &"
  end
  command docker $argv
end
