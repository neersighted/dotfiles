function sudo-toggle
  set command_buffer (commandline)
  if test -z "$command_buffer"
    set command_buffer $history[1]
  end

  set command_split (string match -ir '^(\s*)(sudo\s+)?(.*)' $command_buffer[1])
  test (count $command_buffer) -gt 1
    and set command_multi $command_buffer[2..-1]

  set cursor_position (commandline -C)

  switch (count $command_split)
    case 3
      set whitespace $command_split[2]
      set command $command_split[3]

      commandline -r (string join \n (printf '%ssudo %s' $whitespace $command) $command_multi)

      test $cursor_position -ge (string length $whitespace)
        and set cursor_position (math $cursor_position + 5)
    case 4
      set whitespace $command_split[2]
      set sudo $command_split[3]
      set command $command_split[4]

      commandline -r (string join \n (printf '%s%s' $whitespace $command) $command_multi)

      set whitespace_length (string length $whitespace)
      set sudo_length (string length $sudo)

      if test $cursor_position -ge (math $whitespace_length + $sudo_length)
        set cursor_position (math $cursor_position - $sudo_length)
      else if test $cursor_position -ge $whitespace_length
        set cursor_position $whitespace_length
      end
  end

  commandline -C $cursor_position
end

