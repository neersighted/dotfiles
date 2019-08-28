# function subdirectories
for dir in $__fish_config_dir/functions/**/
  set -p fish_function_path $dir
end

# environment setup
source $__fish_config_dir/environment.fish
source $__fish_config_dir/path.fish

# shell configuration
source $__fish_config_dir/theme.fish
source $__fish_config_dir/settings.fish

# mark shell initialized
set -q fish_initialized; or set -U fish_initialized

# interactive features
source $__fish_config_dir/keys.fish
set -p fish_function_path $__fish_config_dir/prompt

# interactive startup
source $__fish_config_dir/startup.fish
