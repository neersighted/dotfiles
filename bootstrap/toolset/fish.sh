# shellcheck shell=sh

toolset_subsection "fish"

fish=$(command -v fish)
if [ "$(getshell)" != "$fish" ]; then
  if ! grep -Fxq "$fish" /etc/shells; then
    info "Adding $fish to /etc/shells..."
    echo "$fish" | sudo tee -a /etc/shells
  fi

  info "Changing login shell to fish..."
  setshell "$fish"
fi
