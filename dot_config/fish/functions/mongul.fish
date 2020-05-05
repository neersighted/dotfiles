function mongul -d 'quick and dirty mongo(s)'
  set -l options 'n/name=' 'i/image='
  set -a options 'u/user=' 'p/password='
  set -a options 'd/db=' 'l/port='
  set -a options 'L/list' 'D/delete' 'R/reset'

  argparse $options -- $argv
  or return

  set -q _flag_image; or set -l _flag_image mongo:latest
  set -q _flag_port; or set -l _flag_port 27017

  set -l arguments -p $_flag_port:27017
  set -q _flag_user; and set -a arguments -e MONGO_INITDB_ROOT_USERNAME=$_flag_user
  set -q _flag_password; and set -a arguments -e MONGO_INITDB_ROOT_PASSWORD=$_flag_password
  set -q _flag_db; and set -a arguments -e MONGO_INITDB_DATABASE=$_flag_db
  set -a arguments $_flag_image $argv

  if set -q _flag_list
    docker container ls --all --format "{{.Names}}" --filter name=mongul \
      | string replace 'mongul-' '' | string escape
    return
  end

  if not set -q _flag_name # instant, disposable mongodb (destroyed on exit)
    docker run --rm --name mongul $arguments
  else # reusable named mongo
    set -l name mongul-$_flag_name

    if set -q _flag_reset; or set -q _flag_delete
      docker container rm $name
      set -q _flag_delete; and return
    end

    if string match -q $name (docker container ls --all --format "{{.Names}}" --filter name=mongul)
      docker container start --attach $name
    else
      docker run --name $name $arguments
    end
  end
end
