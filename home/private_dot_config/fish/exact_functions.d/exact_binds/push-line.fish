function push-line
  set pushed_commandline (commandline)
  set pushed_cursor (commandline --cursor)
  commandline --replace ''

  function push-line-pop --on-event fish_prompt --inherit-variable pushed_commandline --inherit-variable pushed_cursor
    functions -e (status current-function)

    commandline $pushed_commandline
    commandline --cursor $pushed_cursor
    commandline -f repaint
  end
end
