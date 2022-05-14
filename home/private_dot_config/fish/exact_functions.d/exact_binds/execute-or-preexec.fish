function execute-or-preexec
  if test -z (commandline)
    emit fish_preexec
  end
  commandline -f execute
end
