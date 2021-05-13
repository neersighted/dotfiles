function man
  set -q man_color_blink; or set man_color_blink green
  set -q man_color_bold; or set man_color_bold cyan
  set -q man_color_standout; or set man_color_standout black --background white
  set -q man_color_underline; or set man_color_underline white --underline

  set -x LESS_TERMCAP_mb (set_color $man_color_blink)
  set -x LESS_TERMCAP_md (set_color $man_color_bold)
  set -x LESS_TERMCAP_me (set_color normal)
  set -x LESS_TERMCAP_so (set_color $man_color_standout)
  set -x LESS_TERMCAP_se (set_color normal)
  set -x LESS_TERMCAP_us (set_color $man_color_underline)
  set -x LESS_TERMCAP_ue (set_color normal)
  set -x GROFF_NO_SGR yes

  set -q MANPATH; or set -lx MANPATH ''
  set fish_manpath $__fish_data_dir/man
  test -d $fish_manpath; and set -lx -p MANPATH $fish_manpath

  command man $argv
end
