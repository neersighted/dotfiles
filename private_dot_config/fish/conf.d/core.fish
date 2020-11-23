# core fish configuration
set -qU fish_greeting; or set -U fish_greeting
set -qU fish_term24bit; or set -U fish_term24bit 1
set -qU fish_key_bindings; or set -U fish_key_bindings fish_default_key_bindings
set -qU fish_features; or set -U fish_features stderr-nocaret qmark-noglob

# fish path configuration
set -p fish_complete_path $HOME/.local/etc/fish/completions
