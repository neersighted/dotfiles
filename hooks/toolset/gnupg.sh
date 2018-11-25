# shellcheck shell=sh

toolset_subsection "GnuPG"

if [ -z "$GNUPGHOME" ]; then
  export GNUPGHOME="$HOME/.gnupg"
fi

if [ ! -f "$GNUPGHOME/gpg-agent.conf" ]; then
  info "Configuring gpg-agent..."
  echo "pinentry-program $HOME/.local/bin/pinentry" > "$GNUPGHOME/gpg-agent.conf"
fi
