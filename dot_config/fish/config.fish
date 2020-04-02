# core fish configuration
set -qU fish_key_bindings; or set -U fish_key_bindings fish_default_key_bindings
set -qU fish_features; or set -U fish_features stderr-nocaret qmark-noglob

# function subdirectories
for dir in $__fish_config_dir/functions/**/
  set -p fish_function_path (string trim -rc/ $dir)
end

# environment setup
source $__fish_config_dir/platform.fish
status is-login; and source $__fish_config_dir/environment.fish
set -q fish_initialized; or source $__fish_config_dir/settings.fish
status is-login; and source $__fish_config_dir/paths.fish

# interactive features/startup
if status is-interactive
  source $__fish_config_dir/theme.fish
  set -q fish_initialized; or set -U fish_initialized

  set -p fish_function_path $__fish_config_dir/prompt
  source $__fish_config_dir/keys.fish
  source $__fish_config_dir/startup.fish
end
