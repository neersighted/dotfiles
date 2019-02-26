if not functions -q fisher
  curl -L https://git.io/fisher --create-dirs -o $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end
