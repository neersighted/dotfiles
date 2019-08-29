function __fish_status_prompt -a last_status
  set -l signals  HUP INT QUIT ILL TRAP ABRT EMT FPE KILL BUS SEGV SYS PIPE \
                  ALRM TERM URG STOP TSTP CONT CHLD TTIN TTOU IO XCPU XFSZ \
                  VTALRM PROF WINCH INFO USR1 USR2
  set -l sysexits USAGE DATAERR NOINPUT NOUSER NOHOST UNAVAILABLE SOFTWARE \
                  OSERR OSFILE CANTCREAT IOERR TEMPFAIL PROTOCOL NOPERM CONFIG

  if test $last_status -eq 0
    return
  else if test $last_status -gt 128 -a $last_status -le 165
    set code $signals[(math "$last_status - 128")]
  else if test $last_status -ge 64 -a $last_status -le 78
    set code $sysexits[(math "$last_status - 63")]
  end

  set_color $fish_color_status
  if set -q code
    printf ' %s' $code
  else
    printf ' [%i]' $last_status
  end
  set_color normal
end
