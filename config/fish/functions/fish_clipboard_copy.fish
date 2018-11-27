function fish_clipboard_copy -d 'copy commandline'
  #set -l cmdline (commandline --current-selection)
  #test -n "$cmdline"; or set cmdline (commandline)
  #printf '%s\n' $cmdline | yankee

  commandline | yankee
end
