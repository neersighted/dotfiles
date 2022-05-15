function execute-or-preexec
  set -f commandline (commandline)
  if test -z "$commandline"
    emit fish_preexec
  end
  commandline -f execute
end
