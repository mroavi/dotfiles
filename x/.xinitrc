#!/bin/sh

[ -f ~/.xprofile ] && . ~/.xprofile
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# Start the window manager
exec dwm
