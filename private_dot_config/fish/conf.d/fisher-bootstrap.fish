if not functions -q fisher
  curl -L "https://raw.githubusercontent.com/jorgebucaran/fisher/main/fisher.fish?nocache" --create-dirs -o $__fish_config_dir/functions/fisher.fish
  fish -c fisher
end
