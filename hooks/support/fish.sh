# shellcheck shell=sh

support_subsection "fish"

fish=$(command -v fish)
if [ "$(getshell)" != "$fish" ]; then
  if ! grep -Fxq "$fish" /etc/shells; then
    info "Adding $fish to /etc/shells..."
    echo "$fish" | sudo tee -a /etc/shells
  fi

  info "Changing login shell to fish..."
  case $(uname) in
    FreeBSD)
      su -c "chsh -s '$fish' '$USER'"
      ;;
    *)
      sudo chsh -s "$fish" "$USER"
      ;;
  esac
fi

if [ ! -f "$XDG_CONFIG_HOME/fish/functions/fisher.fish" ]; then
  info "Fetching fisher..."
  curl -L https://git.io/fisher -o "$XDG_CONFIG_HOME/fish/functions/fisher.fish"
else
  info "Updating fisher..."
  fish -c 'fisher self-update'
fi

info "Syncing fish plugins using fisher..."
fish -c 'fisher'
