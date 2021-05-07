status is-interactive; or exit

function rebind -a old new
  if set cmd (bind --user $old | string replace -r '^bind (--user )?\S+ ' '' | string unescape)
    bind --erase $old
    bind $new $cmd
  end
end

function __bind_keys --on-event fish_startup
  bind \r repaint-and-execute
  bind \n repaint-and-execute

  bind ! history-prev-command
  bind \$ history-prev-arguments

  bind \er push-line

  bind \ex tmx
  bind \ez fzfz

  rebind \cf \co # fzf directory
  rebind \cv \ev # fzf variables

  functions -e __bind_keys
end
