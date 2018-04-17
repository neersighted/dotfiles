#!/bin/sh

if ponymix is-muted; then
  echo " -"
else
   echo " $(ponymix get-volume)"
fi
