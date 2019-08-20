function docker
  if set -q WSL; and not test -S /var/run/docker.sock
    and command -sq docker.exe
    and command -sq npiperelay.exe

    sudo (command -s wsl-docker-relay) (command -s npiperelay.exe)
  end

  command docker $argv
end
