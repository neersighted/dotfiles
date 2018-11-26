# automatic fish reconfiguration
function __fish_term24bit --on-variable COLORTERM
  if test "$COLORTERM" = 'truecolor'
    set -g fish_term24bit 1
  else
    set -e fish_term24bit
  end
end

# aggressive color support
if status --is-interactive; and not set -q COLORTERM
  if string match -q -r '^(xterm|linux)$' $TERM
    set -x COLORTERM ''
  else
    set -x COLORTERM 'truecolor'
  end
end
