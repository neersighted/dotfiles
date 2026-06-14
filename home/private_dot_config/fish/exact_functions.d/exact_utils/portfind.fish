function portfind -d "search the ports tree"
  set -q argv[1]; or return
  fd --base-directory /usr/ports --type directory $argv
end
