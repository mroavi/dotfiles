#!/bin/sh

[ -f ~/.xprofile ] && . ~/.xprofile
#[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap # Layout and caps remapping now handled by Xorg config in /etc/X11/xorg.conf.d/00-keyboard.conf

## PolicyKit authentication agent (polkit prompts: fprintd, udisks, fwupd)
#/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &

# Start the window manager
exec dwm
