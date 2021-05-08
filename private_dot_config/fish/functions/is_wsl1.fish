function is_wsl1
  set -q WSLENV; and not set -q WSL_INTEROP
end
