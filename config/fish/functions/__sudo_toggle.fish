function __sudo_toggle
  set -l command_buffer (commandline)
  if test -z "$command_buffer"
    set command_buffer $history[1]
  end

  set -l command_split (string match -ir '^(\s*)(sudo\s+)?(.*)' $command_buffer[1])
  test (count $command_buffer) -gt 1
    and set -l command_multi $command_buffer[2..-1]

  set -l cursor_position (commandline -C)

  switch (count $command_split)
    case 3
      set -l whitespace $command_split[2]
      set -l command $command_split[3]

      commandline -r (string join \n (printf '%ssudo %s' $whitespace $command) $command_multi)

      test $cursor_position -ge (string length $whitespace)
        and set cursor_position (math $cursor_position + 5)
    case 4
      set -l whitespace $command_split[2]
      set -l sudo $command_split[3]
      set -l command $command_split[4]

      commandline -r (string join \n (printf '%s%s' $whitespace $command) $command_multi)

      set -l whitespace_length (string length $whitespace)
      set -l sudo_length (string length $sudo)

      if test $cursor_position -ge (math $whitespace_length + $sudo_length)
        set cursor_position (math $cursor_position - $sudo_length)
      else if test $cursor_position -ge $whitespace_length
        set cursor_position $whitespace_length
      end
  end

  commandline -C $cursor_position
end

