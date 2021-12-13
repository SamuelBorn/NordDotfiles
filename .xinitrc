#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
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


eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

nvidia-settings --assign CurrentMetaMode="DPY-0: nvidia-auto-select @1920x1080 +1920+0 {ForceCompositionPipeline=On}, DPY-2: nvidia-auto-select @1920x1080 +0+0 {ForceCompositionPipeline=On}" &
/home/sam/.screenlayout/main.sh &
exec i3
