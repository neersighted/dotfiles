function prompt_status
  set last_status $argv[-1]
  set last_pipestatus $argv

  if not status_normal $last_status
    set_color $fish_color_status
    if test (count $last_pipestatus) -eq 1
      set signal (status_to_signal $last_status)
      if string match -rq '^\d+$' $signal
        printf ' [%s]' $signal
      else
        printf ' %s' $signal
      end
    else
      for code in $last_pipestatus
        set -a signals (status_to_signal $code)
      end
      printf ' ['
      string join ' | ' $signals
      printf ']'
    end
    set_color normal
  end
end
