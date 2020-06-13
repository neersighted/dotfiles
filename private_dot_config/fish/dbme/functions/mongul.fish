function mongul -d 'quick and dirty mongo(s)'
  set -a options 'n/name=' 'i/image='
  set -a options 'u/user=' 'p/password='
  set -a options 'd/db=' 'l/port='
  set -a options 'C/console' 'L/list' 'D/delete' 'R/reset'

  argparse $options -- $argv
  or return

  set -q _flag_image; or set _flag_image mongo:latest
  set -q _flag_port; or set _flag_port 27017

  set -q _flag_user; and set -a arguments -e MONGO_INITDB_ROOT_USERNAME=$_flag_user
  set -q _flag_password; and set -a arguments -e MONGO_INITDB_ROOT_PASSWORD=$_flag_password
  set -q _flag_db; and set -a arguments -e MONGO_INITDB_DATABASE=$_flag_db
  set -a arguments -p $_flag_port:27017 $_flag_image $argv

  if set -q _flag_console
    set -q _flag_user; and set -a cli_arguments -u $_flag_user
    set -q _flag_password; and set -a cli_arguments -p $_flag_password

    __dbme_console (status current-function) "$_flag_name" mongo $cli_arguments $_flag_db $argv
  else
    __dbme (status current-function) "$_flag_name" "$_flag_list" "$_flag_reset" "$_flag_delete" $arguments
  end
end
