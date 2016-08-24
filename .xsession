#!/bin/bash
 
# Load resources
 
xrdb -merge .Xresources
 
# Set up an icon tray
 
trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 8 --transparent true --tint 0x191970 --height 12 &
 
# Set the background color<
 
#xsetroot -solid midnightblue


#xloadimage -onroot -fullscreen ~/.xmonad/swahili-wallpaper.png -gamma 1.6 -border black
feh --bg-fill ~/.xmonad/swahili-wallpaper.png
 
# Fire up apps
 
 
xscreensaver -no-splash &
 
if [ -x /usr/bin/nm-applet ] ; then
   /usr/bin/nm-applet --sm-disable &
fi
 
#if [ -x /usr/bin/gnome-power-manager ] ; then
#   sleep 3
#   gnome-power-manager &
#fi

if [ -x /usr/bin/skype ] ; then
  /usr/bin/skype &
fi
 
if [ -x /usr/bin/pidgin ] ; then
  /usr/bin/pidgin &
fi

if [ -x  /usr/bin/volumeicon ] ; then
   /usr/bin/volumeicon &
fi

#if [ -x /usr/bin/sonata ] ; then
#   sonata --hidden &
#fi

if [ -x /usr/bin/gbemol ] ; then
   gbemol -m &
fi


if [ -x /usr/bin/tomboy ] ; then
  /usr/bin/tomboy &
fi

if [ -x /usr/bin/volumeicon ] ; then
  /usr/bin/volumeicon &
fi


exec xmonad


