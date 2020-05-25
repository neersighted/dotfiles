function prompt_duration -a last_duration
  if test "$last_duration" -ne 0
    set s (math -s3 "$last_duration / 1000 % 60")
    set m (math -s0 "$last_duration / 1000 / 60 % 60")
    set h (math -s0 "$last_duration / 1000 / 60 / 60 % 24")
    set d (math -s0 "$last_duration / 1000 / 60 / 60 / 24")
  else
    return
  end

  set_color $fish_color_timer
  if test "$last_duration" -gt 1000
    test $d -gt 0; and printf ' %sd' $d
    test $h -gt 0; and printf ' %sh' $h
    test $m -gt 0; and printf ' %sm' $m
    test $s -gt 0; and printf ' %ss' $s
  else
    printf ' %sms' $last_duration
  end
  set_color normal
end
