#!/bin/sh

if command -v poetry >/dev/null; then
  poetry completions
fi
