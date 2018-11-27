function man -d 'display manpages'
  set -q man_blink; or set -l man_blink green
  set -q man_bold; or set -l man_bold cyan
  set -q man_standout; or set -l man_standout black -b white
  set -q man_underline; or set -l man_underline -u white

  set -lx LESS_TERMCAP_mb (set_color $man_blink)
  set -lx LESS_TERMCAP_md (set_color $man_bold)
  set -lx LESS_TERMCAP_me (set_color normal)
  set -lx LESS_TERMCAP_so (set_color $man_standout)
  set -lx LESS_TERMCAP_se (set_color normal)
  set -lx LESS_TERMCAP_us (set_color $man_underline)
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
