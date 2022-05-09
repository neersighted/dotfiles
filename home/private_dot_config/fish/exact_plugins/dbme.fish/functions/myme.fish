function myme -d 'quick and dirty mysql(es)'
  set -a options 'n/name=' 'i/image='
  set -a options 'u/user=' 'p/password='
  set -a options 'P/root-password=' 's/sha2-auth'
  set -a options 'd/db=' 'l/port='
  set -a options 'C/console' 'L/list' 'D/delete' 'R/reset'

  argparse $options -- $argv
  or return

  set -q _flag_image; or set _flag_image mysql:latest
  set -q _flag_port; or set _flag_port 3306

  set -q _flag_user; and set -a arguments -e MYSQL_USER=$_flag_user 
  set -q _flag_password; and set -a arguments -e MYSQL_PASSWORD=$_flag_password
  set -q _flag_root_password; and set -a arguments -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -e MYSQL_ROOT_PASSWORD="$_flag_root_password"
  set -q _flag_root_password; or set -a arguments -e MYSQL_RANDOM_ROOT_PASSWORD=yes
  set -q _flag_db; and set -a arguments -e MYSQL_DATABASE=$_flag_db
  set -a arguments -p $_flag_port:3306 $_flag_image $argv
  set -q _flag_sha2_auth; or set -a arguments --default-authentication-plugin=mysql_native_password

  if set -q _flag_console
    set -q _flag_user; and set -a cli_arguments -u $_flag_user
    set -q _flag_password; and set -a cli_arguments -p $_flag_password
    set -q _flag_root_password; and set -a cli_arguments -p $_flag_root_password

    __dbme_console (status current-function) "$_flag_name" mysql $cli_arguments $_flag_db $argv
  else
    __dbme (status current-function) "$_flag_name" "$_flag_list" "$_flag_reset" "$_flag_delete" $arguments
  end
end
