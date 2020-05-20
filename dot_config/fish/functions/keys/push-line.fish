function push-line
    set pushed_commandline (commandline)
    set pushed_cursor (commandline -C)
    commandline ''

    function push-line-pop --on-event fish_prompt --inherit-variable pushed_commandline --inherit-variable pushed_cursor
        commandline $pushed_commandline
        commandline -C $pushed_cursor
        commandline -f repaint

        functions -e (status current-function)
    end
end
