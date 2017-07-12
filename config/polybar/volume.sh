#!/usr/bin/env bash

if ponymix is-muted; then
  echo " -"
else
   echo " $(ponymix get-volume)"
fi
