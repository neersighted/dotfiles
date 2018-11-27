function man -d 'display manpages'
  set -q man_color_blink; or set -l man_color_blink green
  set -q man_color_bold; or set -l man_color_bold cyan
  set -q man_color_standout; or set -l man_color_standout black --background white
  set -q man_color_underline; or set -l man_color_underline white --underline

  set -lx LESS_TERMCAP_mb (set_color $man_color_blink)
  set -lx LESS_TERMCAP_md (set_color $man_color_bold)
  set -lx LESS_TERMCAP_me (set_color normal)
  set -lx LESS_TERMCAP_so (set_color $man_color_standout)
  set -lx LESS_TERMCAP_se (set_color normal)
  set -lx LESS_TERMCAP_us (set_color $man_color_underline)
  set -lx LESS_TERMCAP_ue (set_color normal)
  set -lx GROFF_NO_SGR yes

  set -lx LESS "$LESS -R -M +Gg"

  set -l manpath
  if set -q MANPATH
    set manpath $MANPATH
  else
    set manpath ''
  end
  set -lx MANPATH $manpath

  set -l fish_manpath (dirname $__fish_datadir)/fish/man
  if test -d $fish_manpath
    set MANPATH $fish_manpath $MANPATH
  end

  command man $argv
end
