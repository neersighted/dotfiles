function __fish_prompt_status_humanize -d 'convert status codes to readable names' -a code
  set special  INVALCHAR EMPTYGLOB EXECFORMAT NOEXEC NOTFOUND
  set signals  HUP INT QUIT ILL TRAP ABRT EMT FPE KILL BUS SEGV SYS PIPE \
               ALRM TERM URG STOP TSTP CONT CHLD TTIN TTOU IO XCPU XFSZ \
               VTALRM PROF WINCH INFO USR1 USR2
  set sysexits USAGE DATAERR NOINPUT NOUSER NOHOST UNAVAILABLE SOFTWARE \
               OSERR OSFILE CANTCREAT IOERR TEMPFAIL PROTOCOL NOPERM CONFIG

  if test $code -gt 122 -a $code -le 127
    printf '%s' $special[(math "$code - 122")]
  else if test $code -gt 128 -a $code -le 165
    printf 'SIG%s' $signals[(math "$code - 128")]
  else if test $code -gt 63 -a $code -le 78
    printf 'EX_' $sysexits[(math "$code - 63")]
  else
    printf '%i' $code
  end
end

function fish_status_prompt
  set last_status $argv[-1]
  set last_pipestatus $argv

  if not __fish_prompt_status_normal $last_status
    set_color $fish_color_status
    if test (count $last_pipestatus) -eq 1
      set signal (__fish_prompt_status_humanize $last_status)
      if string match -rq '^\d+$' $signal
        printf ' [%s]' $signal
      else
        printf ' %s' $signal
      end
    else
      for code in $last_pipestatus
        set -a signals (__fish_prompt_status_humanize $code)
      end
      printf ' ['
      string join ' | ' $signals
      printf ']'
    end
    set_color normal
  end
end
