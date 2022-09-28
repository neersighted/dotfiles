#!/usr/bin/env bash
set -e

LOADED_KEYS=$(ssh-add -L | cut -d' ' -f1,2)
KNOWN_KEYS=$(gh api /user/ssh_signing_keys -q '.[].key')

printf 'key::%s' "$(comm -12 <(printf '%s' "$LOADED_KEYS" | sort) <(printf '%s' "$KNOWN_KEYS" | sort) | head -n1)"
