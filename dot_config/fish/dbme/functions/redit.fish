function redit -d 'quick and dirty redis(es)'
  set -a options 'n/name=' 'i/image='
  set -a options 'c/config=' 'l/port='
  set -a options 'C/console' 'L/list' 'D/delete' 'R/reset'

  argparse $options -- $argv
  or return

  set -q _flag_image; or set _flag_image redis:latest
  set -q _flag_port; or set _flag_port 6379

  set -q _flag_config; and set _flag_config (builtin realpath $_flag_config)

  set -q _flag_config; and set -a arguments -v $_flag_config:/etc/redis.conf
  set -a arguments -p $_flag_port:6379 $_flag_image
  set -q _flag_config; and set -a arguments redis-server /etc/redis.conf $argv
  set -q _flag_config; or set -a arguments redis-server --appendonly yes $argv

  if set -q _flag_console
    __dbme_console (status current-function) "$_flag_name" redis-cli $argv
  else
    __dbme (status current-function) "$_flag_name" "$_flag_list" "$_flag_reset" "$_flag_delete" $arguments
  end
end
