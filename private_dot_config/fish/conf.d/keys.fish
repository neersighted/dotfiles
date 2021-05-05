status is-interactive; or exit

bind \r repaint-and-execute
bind \n repaint-and-execute

bind ! history-prev-command
bind \$ history-prev-arguments

bind \er push-line
bind \ex tmx
bind \ez fzfz

bind --erase \cf
bind \co __fzf_search_current_dir
bind --erase \cv
bind \ev '__fzf_search_shell_variables (set --show | psub) (set --names | psub)'
