complete -c redit -s n -l name -xa '(redit -L)' -d 'instance name'
complete -c redit -s i -l image -x -d 'docker image'
complete -c redit -s c -l config -r -d 'tcp port'
complete -c redit -s l -l port -x -d 'tcp port'

complete -c redit -s C -l console -f -d 'open console/cli'
complete -c redit -s L -l list -f -d 'list instances'
complete -c redit -s D -l delete -f -d 'delete instance'
complete -c redit -s R -l reset -f -d 'reset instance'
