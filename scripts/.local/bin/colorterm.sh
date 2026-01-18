#!/bin/sh

# https://bryangilbert.com/post/etc/term/dynamic-ssh-terminal-background-colors/

# No arguments passed?
if [ "$#" == 0 ]; then
  # True, then set the default color (the SSH connection was closed)
  printf '\033]11;#1E1E2E\007'
  exit 0
fi

# Otherwise, set the color based on the hostname
if [ "$1" == "merlin" ]; then
  printf '\033]11;#3A1414\007'
elif [ "$1" == "panterita" ]; then
  printf '\033]11;#0F2F1F\007'
else
  # Other hostname
  printf '\033]11;#1C2433\007'
fi
