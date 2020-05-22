# core fish configuration
set -qU fish_term24bit; or set -U fish_term24bit 1
set -qU fish_key_bindings; or set -U fish_key_bindings fish_default_key_bindings
set -qU fish_features; or set -U fish_features stderr-nocaret qmark-noglob

# function subdirectories
for dir in $__fish_config_dir/functions/*
  test -d $dir; and set -p fish_function_path $dir
end

# environment setup
source $__fish_config_dir/platform.fish
source $__fish_config_dir/environment.fish
source $__fish_config_dir/sockets.fish

# interactive features/startup
if status is-interactive
  source $__fish_config_dir/theme.fish
  set -p fish_function_path $__fish_config_dir/prompt
  source $__fish_config_dir/keys.fish
  source $__fish_config_dir/startup.fish
end
