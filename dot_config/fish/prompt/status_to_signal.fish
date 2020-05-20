function status_to_signal -d 'convert status codes to readable names' -a code
  set special  INVALCHAR EMPTYGLOB EXECFORMAT NOEXEC NOTFOUND
  set signals  HUP INT QUIT ILL TRAP ABRT EMT FPE KILL BUS SEGV SYS PIPE \
               ALRM TERM URG STOP TSTP CONT CHLD TTIN TTOU IO XCPU XFSZ \
               VTALRM PROF WINCH INFO USR1 USR2
  set sysexits USAGE DATAERR NOINPUT NOUSER NOHOST UNAVAILABLE SOFTWARE \
               OSERR OSFILE CANTCREAT IOERR TEMPFAIL PROTOCOL NOPERM CONFIG

  if test $code -ge 123 -a $code -le 127
    printf '%s' $special[(math "$code - 120")]
  else if test $code -gt 128 -a $code -le 165
    printf 'SIG%s' $signals[(math "$code - 128")]
  else if test $code -ge 64 -a $code -le 78
    printf 'EX_' $sysexits[(math "$code - 63")]
  else
    printf '%i' $code
  end
end
