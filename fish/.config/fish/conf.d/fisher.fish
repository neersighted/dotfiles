set -g fisher_path $__fish_config_dir/fisher

set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]
for file in $fisher_path/conf.d/*.fish
  source $file 2>/dev/null
end

if not functions -q fisher
  curl -L https://git.io/fisher --create-dirs -o $fisher_path/functions/fisher.fish
  fish -c fisher
end
