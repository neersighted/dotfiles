# shellcheck shell=sh

toolset_subsection "ngrok"

if ! command -v ngrok >/dev/null; then
  info "Installing ngrok..."

  goversion=$(go version | awk '{print $4}')
  GOOS=${goversion%/*}
  GOARCH=${goversion#*/}

  curl "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-$GOOS-$GOARCH.zip" | funzip > "$HOME/.local/bin/ngrok"
  chmod +x "$HOME/.local/bin/ngrok"
else
  info "Updating ngrok..."
  ngrok update
fi
