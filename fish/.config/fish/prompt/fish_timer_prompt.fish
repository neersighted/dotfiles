function fish_timer_prompt -a dur
  if test "$dur" -eq 0
    return
  else if test "$dur" -lt 1000
    set time $dur"ms"
  else if test "$dur" -lt 60000
    set time (math -s1 "$dur / 1000")"s"
  else if test "$dur" -lt 3600000
    set time (math -s1 "$dur / 1000 / 60")"m"
  else if test "$dur" -lt 86400000
    set time (math -s1 "$dur / 1000 / 60 / 60")"h"
  else
    set time (math -s2 "$dur / 1000 / 60 / 60 / 24")"d"
  end

  set_color $fish_color_timer
  if set -q time
    printf ' %s' $time
  end
  set_color normal
end
