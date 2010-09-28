#!/bin/bash
wait

RAMDISK_DIR=/dev/shm

WP_LIST=$RAMDISK_DIR/wallpaper_templist
WALLPAPER_DIR=/home/samuel/commands/dynamic_wallpapers/wallpapers
WALLPAPER_LINK=/home/samuel/commands/dynamic_wallpapers/wallpaper


if [ "$#" == 0 ]; then
	cfilenam=`tac $WP_LIST|sed -n -e '1p'`
else
	cfilenam=`echo $@`
fi
# echo "debug: handle file:"
# echo "debug: $cfilenam"

rm $WP_LIST
wait
ls -c $WALLPAPER_DIR > $WP_LIST
wait

LINENUMBER=`wc -l $WP_LIST |awk '{print $1}'`
#lfilenam=`tac $WP_LIST|sed -n -e '1p'`
wait

#echo "debug: cf $cfilenam"
#echo "debug: lf $lfilenam"
#echo "debug: total files:$LINENUMBER"

#for indx in $(seq $LINENUMBER)
for (( indx=0; indx<=$LINENUMBER; indx=indx+1 ))
do
	lfilenam=`tac $WP_LIST|sed -n -e '1p'`
#echo "debug: go again"
#echo "debug: $indx of total $LINENUMBER"
	wait

	if [ "$cfilenam" == "$lfilenam" ] && [ "$indx" != $LINENUMBER ]; then
#echo "debug: ok, so ..."
		#exit 0
		break
	else
#echo "debug: no ok, so ..."
		cat $WP_LIST |\
			sed -n -e '1p' >> $WP_LIST |\
			sed -i $WP_LIST -e '1d'
		wait
		continue
	fi
done
wait
# set the oldest to it
# click updatewallpaper will be latest
tac $WP_LIST|sed -n -e '1p'|\
	xargs -I file ln -f -s $WALLPAPER_DIR/file \
	$WALLPAPER_LINK
