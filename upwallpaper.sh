#!/bin/bash

RAMDISK_DIR=/dev/shm

WALLPAPER_LINK=/home/samuel/commands/dynamic_wallpapers/wallpaper
WALLPAPER_LIST=$RAMDISK_DIR/wallpaper_templist
COMM_ROOT_DIR=/home/samuel/commands/dynamic_wallpapers

wait
$COMM_ROOT_DIR/reflesh_list.sh
wait
# rotate the list
if [ "$1" == "-r" ]; then
	(echo `tac $WALLPAPER_LIST |\
		sed -n -e '1p'`; cat $WALLPAPER_LIST) > $RAMDISK_DIR/wallpaper_new_templist
	wait
	mv $RAMDISK_DIR/wallpaper_new_templist $WALLPAPER_LIST
	wait
	sed -i $WALLPAPER_LIST -e '$d'
	wait

else 
	cat $WALLPAPER_LIST |\
		sed -n -e '1p' >> $WALLPAPER_LIST |\
		sed -i $WALLPAPER_LIST -e '1d'
	wait
fi

wait
# set the wallpaper
tac $WALLPAPER_LIST |\
	sed -n -e '1p' |\
	tee $RAMDISK_DIR/wallpaper_slink_location |\
	xargs -I file ln -f -s $WALLPAPER_LINK's/file' \
	  $WALLPAPER_LINK 
	wait

# set background in gnome
gconftool-2 -s -t string /desktop/gnome/background/picture_filename \
 $WALLPAPER_LINK
wait

# Notify-Feature
# declare -x DISPLAY=":0.0"
cat $RAMDISK_DIR/wallpaper_slink_location | xargs -I file notify-send "file" 2> /dev/null
wait
rm $RAMDISK_DIR/wallpaper_slink_location
wait
