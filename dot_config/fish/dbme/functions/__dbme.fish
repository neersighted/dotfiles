function __dbme -a dbme name list reset delete
  set arguments $argv[6..-1]

  if test -n "$list"
    docker container ls --all --format "{{.Names}}" --filter name=$dbme \
      | string replace "$dbme-" '' | string escape
    return
  end

  if test -z "$name" # instant, disposable database (destroyed on exit)
    docker run --rm --name $dbme $arguments
  else # reusable named database
    set name $dbme-$name

    if test -n "$reset"; or test -n "$delete"
      docker container rm $name
      test -n "$delete"; and return
    end

    if string match -q $name (docker container ls --all --format "{{.Names}}" --filter name=$name)
      docker container start --attach $name
    else
      docker run --name $name $arguments
    end
  end
end
