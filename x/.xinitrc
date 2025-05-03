#!/bin/sh

[ -f ~/.xprofile ] && . ~/.xprofile
#[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap # Layout and caps remapping now handled by Xorg config in /etc/X11/xorg.conf.d/00-keyboard.conf

# Start the window manager
exec dwm
