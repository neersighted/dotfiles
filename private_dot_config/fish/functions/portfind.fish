is_freebsd; or exit

function portfind -d "search the ports tree"
  fd --base-directory /usr/ports --type directory $argv
end
