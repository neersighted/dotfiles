function fish_clipboard_paste
  # Load the clipboard.
  set -l data (yankee-paste)
  # Correct errant newlines.
  set -l data (string split \r -- $data)

  # If the current token has an unmatched single-quote,
  # escape all single-quotes (and backslashes) in the paste,
  # in order to turn it into a single literal token.
  #
  # This eases pasting non-code (e.g. markdown or git commitishes).
  if __fish_commandline_is_singlequoted
    set data (string replace -ra "(['\\\])" '\\\\\\\$1' -- $data)
  end
  if test -n "$data"
    commandline -i -- $data
  end
end
