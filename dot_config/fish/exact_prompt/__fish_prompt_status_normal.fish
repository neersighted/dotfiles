function __fish_prompt_status_normal -a code
  # ignore status 141 (SIGPIPE) as this is rarely an error
  if test $code -ne 0 -a $code -ne 141
    return 1
  end
end
