function pgme -d 'quick and dirty postgres(es)'
  set -a options 'n/name=' 'i/image='
  set -a options 'u/user=' 'p/password='
  set -a options 'd/db=' 'l/port='
  set -a options 'C/console' 'L/list' 'D/delete' 'R/reset'

  argparse $options -- $argv
  or return

  set -q _flag_image; or set _flag_image postgres:latest
  set -q _flag_port; or set _flag_port 5432
  set -q _flag_user; or set _flag_user postgres
  set -q _flag_password; or set _flag_password password
  set -q _flag_db; or set _flag_db postgres

  set -a arguments -e POSTGRES_USER=$_flag_user -e POSTGRES_PASSWORD=$_flag_password
  set -a arguments -e POSTGRES_DB=$_flag_db
  set -a arguments -p $_flag_port:5432 $_flag_image $argv

  if set -q _flag_console
    __dbme_console (status current-function) "$_flag_name" psql $_flag_db $argv
  else
    __dbme (status current-function) "$_flag_name" "$_flag_list" "$_flag_reset" "$_flag_delete" $arguments
  end
end
