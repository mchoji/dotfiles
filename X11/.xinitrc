#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#
CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/X11
userresources=$CONFIG_DIR/xresources
usermodmap=$CONFIG_DIR/xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Set environment
XDG_SESSION_TYPE_OLD=${XDG_SESSION_TYPE}
export XDG_SESSION_TYPE=X11

#exec startxfce4
exec awesome

# Reset environment
export XDG_SESSION_TYPE=${XDG_SESSION_TYPE_OLD}
