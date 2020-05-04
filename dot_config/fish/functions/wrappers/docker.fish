if is_wsl1
  function docker
    if not test -S /var/run/docker.sock
      and command -q docker.exe
      and command -q npiperelay.exe

      sudo (command -s wsl-docker-relay) (command -s npiperelay.exe)
    end

    command docker $argv
  end
end
