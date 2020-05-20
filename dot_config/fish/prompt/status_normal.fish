function status_normal -d 'check if status is normal or an error' -a code
  # ignore status 141 (SIGPIPE) as this is rarely an error
  if test $code -ne 0 -a $code -ne 141
    return 1
  end
end
