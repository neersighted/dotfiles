function dockit -d 'run a throwaway docker container interactively'
  docker run --pull=always --rm -it $argv
end
