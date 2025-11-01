#!/usr/bin/env bash
set -e

GITHUB_USER="neersighted"
API_ENDPOINT="/users/$GITHUB_USER/ssh_signing_keys"

if command -v gh >/dev/null; then
  known_keys=$(gh api $API_ENDPOINT -q '.[].key')
else
  known_keys=$(curl -fSsL https://api.github.com/$API_ENDPOINT | yq '.[].key')
fi

loaded_keys=$(ssh-add -L | cut -d' ' -f1,2)

printf 'key::%s' "$(comm -12 <(printf '%s' "$loaded_keys" | sort) <(printf '%s' "$known_keys" | sort) | head -n1)"
