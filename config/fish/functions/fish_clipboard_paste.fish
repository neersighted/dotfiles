function fish_clipboard_paste -d 'paste onto commandline'
  set -l data (yankee -o)
  # turn \r into newlines
  set data (string split \r -- $data)
  # escape single quotes if neede
  if __fish_commandline_is_singlequoted
    set data (string replace -ar "(['\\\])" '\\\\\\\$1' -- $data)
  end

  if test -n "$data"
    commandline -i -- $data
  end
end
