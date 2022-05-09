function fuck -d "Correct your previous console command"
  set -x TF_SHELL fish
  set -x TF_ALIAS fuck
  set -x PYTHONIOENCODING utf-8

  set fucked_up_command $history[1]
  thefuck $fucked_up_command THEFUCK_ARGUMENT_PLACEHOLDER $argv | read unfucked_command

  if test "$unfucked_command" != ""
    eval $unfucked_command
    history delete --exact --case-sensitive -- $fucked_up_command
    history merge 2>/dev/null
  end
end
