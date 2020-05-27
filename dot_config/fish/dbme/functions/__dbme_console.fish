function __dbme_console -a dbme name cmd
  set arguments $argv[4..-1]

  isatty 0; and set interactive -it
  test -n "$name"; and set name $dbme-$name; or set name $dbme

  docker exec $interactive $dbme $cmd $arguments
end

