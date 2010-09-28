#!/bin/bash
#
# Wallpaper Image Source Link Updater
#
# Author: samuelololol
# Email: samuelololol@gmail.com
# Data: Mar, 2101
#

APP_NAME="Wallpaper Image Source Link Updater"
APP_RELEASE="BATA"
APP_VERSION="0.3"

COMM_ROOT_DIR=/home/samuel/commands/dynamic_wallpapers
WALLPAPER_DIR=$COMM_ROOT_DIR/wallpapers
RAMDISK_DIR=/dev/shm

function get_typemoon()
{
	if [ -z "$1" ]; then
		echo "Error: Typemoon sources type(0-6)"
		return 1

	elif [ "$1" == "0" ]; then
		page="index.html"
		echo "Update from $page"

	elif [ "$1" == "1" ]; then
		page="1.html"
		echo "Update from $page"

	elif [ "$1" == "2" ]; then
		page="2.html"
		echo "Update from $page"

	elif [ "$1" == "3" ]; then
		page="3.html"
		echo "Update from $page"

	elif [ "$1" == "4" ]; then
		page="4.html"
		echo "Update from $page"

	elif [ "$1" == "5" ]; then
		page="5.html"
		echo "Update from $page"

	elif [ "$1" == "6" ]; then
		page="6.html"
		echo "Update from $page"

	elif [ "$1" == "all" ]; then
		echo "Update from all..."
		get_typemoon 0
		wait
		get_typemoon 1
		wait
		get_typemoon 2
		wait
		get_typemoon 3
		wait
		get_typemoon 4
		wait
		get_typemoon 5
		wait
		get_typemoon 6
		wait

		return 0
	else 
		echo "Error: Update source error"
		return 1
	fi

	wait
	wget -o /dev/null -q -O $RAMDISK_DIR/typemoon_wallpaper_bbs.html \
		http://phantom002.sakura.ne.jp/bbs2/$page 2>/dev/null
	wait
	#echo "iconv $page"
	iconv -f SHIFT_JIS -t UTF-8 $RAMDISK_DIR/typemoon_wallpaper_bbs.html > $RAMDISK_DIR/typemoon_wallpaper.html
	wait
	grep "画像タイトル：" $RAMDISK_DIR/typemoon_wallpaper.html|\
		sed -e 's/.*a href=\"//g' -e 's/..target=_blank.*//g' |\
		xargs -I filesource echo "http://phantom002.sakura.ne.jp/bbs2/"filesource >>   $RAMDISK_DIR/wallpaper_link
	
	wait
	return 0
}

function get_konachan()
{
	if [ -z "$1" ]; then
		echo "Error: Konachan.com sources type(d/m/y)"
		return 1
	elif [ "$1" == "d" ]; then
		echo "Update from daily popular..."
	elif [ "$1" == "w" ]; then
		echo "Update from weekly popular..."
	elif [ "$1" == "m" ]; then
		echo "Update from monthly popular..."
	elif [ "$1" == "y" ]; then
		echo "Update from yearly popular..."
	elif [ "$1" == "all" ]; then
		echo "Update from all..."
		get_konachan "d"
		wait
		get_konachan "w"
		wait
		get_konachan "m"
		wait
		get_konachan "y"
		wait
		return 0
	else 
		echo "Error: Update source error"
		return 1
	fi

	wget -o /dev/null -q -O $RAMDISK_DIR/konachan_wallpaper.html \
		http://konachan.com/post/popular_recent?period=1$1 2>/dev/null
	wait

	grep "similarhr"  $RAMDISK_DIR/konachan_wallpaper.html  |\
		sed -e 's/.*similarhr\" href=\"//g' -e 's/\"..span.*//g' >> $RAMDISK_DIR/wallpaper_link
	wait

	grep "similarlr"  $RAMDISK_DIR/konachan_wallpaper.html  |\
		sed -e 's/.*similarlr\" href=\"//g' -e 's/\"..span.*//g' >> $RAMDISK_DIR/wallpaper_link
	wait

	return 0
}

function download_image()
{
	echo "there are $(wc -l $RAMDISK_DIR/wallpaper_link | awk '{print $1}') files will be download"
	wget -nc -i $RAMDISK_DIR/wallpaper_link \
		-P $WALLPAPER_DIR/ 2>/dev/null
	wait
	# set the lastest on
	$COMM_ROOT_DIR/reflesh_list.sh

	# It's not need to update to next wallpaper
	#$COMM_ROOT_DIR/upwallpaper.sh 

	rm $RAMDISK_DIR/wallpaper_link
	return 0
}



if [ "$#" == 0 ]; then
	echo
	echo
	echo "$APP_NAME $APP_RELEASE v.$APP_VERSION"
	echo
	read -p "Update source? konachan(k)/typemoon(t)/all(all):" usource

	if [ "$usource" == "k" ]; then
		read -p "Konachan.com source type: download daily(d)/monthly(m)/yearly(y)/all(all):" option
		rm $RAMDISK_DIR/wallpaper_link 2>/dev/null
		wait
		get_konachan $option
		wait
		rm $RAMDISK_DIR/konachan_wallpaper.html  2>/dev/null
		rtnv=$?
	elif [ "$usource" == "t" ]; then
		read -p "Typemoon source page: index.html(0)/[1-6].html(1-6)/all(all):" option
		rm $RAMDISK_DIR/wallpaper_link  2>/dev/null
		wait
		get_typemoon $option
		wait
		rm $RAMDISK_DIR/typemoon_wallpaper.html 2>/dev/null
		rtnv=$?
	elif [ "$usource" == "all" ]; then
		rm $RAMDISK_DIR/wallpaper_link  2>/dev/null
		wait
		get_konachan all
		wait
		rm $RAMDISK_DIR/konachan_wallpaper.html 2>/dev/null
		wait
		get_typemoon all
		wait
		rm $RAMDISK_DIR/typemoon_wallpaper.html 2>/dev/null
		rtnv=$?
	else
		echo "Error: update source"
		exit 0
	fi

	if [ "$rtnv" == 1 ]; then
		exit 0
	fi

elif [ "$#" == 1 ] && [ "$1" == "all" ]; then
	rm $RAMDISK_DIR/wallpaper_link  2>/dev/null
	wait
	get_konachan all
	wait
	rm $RAMDISK_DIR/konachan_wallpaper.html 2>/dev/null
	wait
	get_typemoon all
	wait
	rm $RAMDISK_DIR/typemoon_wallpaper.html 2>/dev/null
	wait

# Hide Option, download ALLLLLLL, whatever it is!
elif [ "$#" == 2 ] && [ "$1" == "all" ] && [ "$2" == "18x" ]; then
	rm $RAMDISK_DIR/wallpaper_link  2>/dev/null
	wait
	get_konachan all
	wait
	rm $RAMDISK_DIR/konachan_wallpaper.html 2>/dev/null
	get_typemoon all
	wait
	rm $RAMDISK_DIR/typemoon_wallpaper.html 2>/dev/null
	wait

	download_image 
	wait
	echo 
	echo "Download completed."
	echo
	exit 0
fi
wait
#cp $RAMDISK_DIR/wallpaper_link $RAMDISK_DIR/wallpaper_link.bak
$COMM_ROOT_DIR/del_ignore.sh -l $RAMDISK_DIR/wallpaper_link
wait
download_image 
wait
echo 
echo "Download completed."
echo
