#!/bin/sh

# Source user xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# Start the window manager
exec dwm
