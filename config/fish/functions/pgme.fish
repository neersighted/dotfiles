function pgme -d 'quick and dirty postgres(es)'
  set -l options 'n/name=' 'i/image='
  set -a options 'u/user=' 'p/password='
  set -a options 'd/db=' 'l/port='
  set -a options 'L/list' 'D/delete' 'R/reset'

  argparse --name=pgme $options -- $argv
  or return

  set -q _flag_image; or set -l _flag_image postgres:latest
  set -q _flag_user; or set -l _flag_user postgres
  set -q _flag_password; or set -l _flag_password postgres
  set -q _flag_db; or set -l _flag_db postgres
  set -q _flag_port; or set -l _flag_port 5432

  set -l arguments -e POSTGRES_USER=$_flag_user -e POSTGRES_PASSWORD=$_flag_password
  set -a arguments -e POSTGRES_DB=$_flag_db -p $_flag_port:5432
  set -a arguments $_flag_image $argv

  if set -q _flag_list
    docker container ls --all --format "{{.Names}}" --filter name=pgme \
      | string replace 'pgme-' '' | string escape
    return
  end

  if not set -q _flag_name # instant, disposable postgres (destroyed on exit)
    docker run --rm --name pgme $arguments
  else # reusable named postgres
    set -l name pgme-$_flag_name

    if set -q _flag_reset; or set -q _flag_delete
      docker container rm $name
      set -q _flag_delete; and return
    end

    if string match -q $name (docker container ls --all --format "{{.Names}}" --filter name=pgme)
      docker container start --attach $name
    else
      docker run --name $name $arguments
    end
  end
end
