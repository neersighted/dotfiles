function docker -d 'docker client'
  if not test -S /var/run/docker.sock
    and command -sq docker.exe
    and command -sq npiperelay.exe

    sudo (command -s docker-relay) (command -s npiperelay.exe)
  end
  command docker $argv
end
