if not functions -q fisher
  curl -L https://git.io/fisher --create-dirs -o $__fish_config_dir/functions/fisher.fish
  fish -c fisher
end
