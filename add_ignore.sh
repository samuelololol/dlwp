#!/bin/bash

RAMDISK_DIR=/dev/shm

COMM_ROOT_DIR=/home/samuel/commands/dynamic_wallpapers
WALLPAPER_LIST=$RAMDISK_DIR/wallpaper_templist
IGNORE_LIST=/home/samuel/commands/dynamic_wallpapers/ignore_list
X18_LIST=/home/samuel/commands/dynamic_wallpapers/18x_list


if [ "$1" == "-m" ]; then
	tac $WALLPAPER_LIST |\
		sed -n -e '1p' |\
		tee -a $X18_LIST |\
		xargs -I name notify-send "Add name to 18x"
	wait
	$COMM_ROOT_DIR/del_ignore.sh $1 $2

elif [ "$1" == "-d" ]; then
	tac $WALLPAPER_LIST |\
		sed -n -e '1p' |\
		tee -a $IGNORE_LIST |\
		xargs -I name notify-send "Add name to ignore"
	wait
	$COMM_ROOT_DIR/del_ignore.sh $1
fi

notify-send $(tac $RAMDISK_DIR/wallpaper_templist|sed -n -e '1p')
