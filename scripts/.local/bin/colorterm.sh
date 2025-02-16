#!/bin/sh

# https://bryangilbert.com/post/etc/term/dynamic-ssh-terminal-background-colors/

# No arguments passed?
if [ "$#" == 0 ]; then
  # True, then set the default color (the SSH connection was closed)
  printf '\033]11;#1E1E2E\007'
  exit 0
fi

# Otherwise, set the color based on the hostname
if [ "$1" == "raspi" ]; then
  printf '\033]11;#192436\007'
elif [ "$1" == "co23" ]; then
  printf '\033]11;#232136\007'
elif [ "$1" == "hpc" ]; then
  printf '\033]11;#1F2A3B\007'
else
  # Other hostname
  printf '\033]11;#331C1F\007'
fi
