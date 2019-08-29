function man -d 'display manpages'
  set -q man_color_blink; or set man_color_blink green
  set -q man_color_bold; or set man_color_bold cyan
  set -q man_color_standout; or set man_color_standout black --background white
  set -q man_color_underline; or set man_color_underline white --underline

  set -lx LESS_TERMCAP_mb (set_color $man_color_blink)
  set -lx LESS_TERMCAP_md (set_color $man_color_bold)
  set -lx LESS_TERMCAP_me (set_color normal)
  set -lx LESS_TERMCAP_so (set_color $man_color_standout)
  set -lx LESS_TERMCAP_se (set_color normal)
  set -lx LESS_TERMCAP_us (set_color $man_color_underline)
  set -lx LESS_TERMCAP_ue (set_color normal)
  set -lx GROFF_NO_SGR yes

  set -lx LESS "$LESS -R -M +Gg"

  set fish_manpath (dirname $__fish_data_dir)/fish/man

  set -q MANPATH; or set -lx MANPATH ''
  test -d $fish_manpath; and set -lx -p MANPATH $fish_manpath

  command man $argv
end
