function execute-or-preexec
  set -f commandline (commandline)
  if test -z "$commandline"
    emit histsync
  end
  commandline -f execute
end
