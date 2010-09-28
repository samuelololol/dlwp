#!/bin/bash

RAMDISK_DIR=/dev/shm

CHK_LIST=/home/samuel/commands/dynamic_wallpapers/ignore_list
X18_LIST=/home/samuel/commands/dynamic_wallpapers/18x_list
SLAVE_LIST=$RAMDISK_DIR/chk_slave_list
FIN_LIST=$RAMDISK_DIR/chk_fin_list

CHK_TARGET=`cat $CHK_LIST|tee $SLAVE_LIST|sed -n -e '1p'`
wait
rm $FIN_LIST 2>/dev/null
while [ "$CHK_TARGET" != "" ]
do
	CHK_TARGET=`cat $SLAVE_LIST|sed -n -e '1p'`
	sed -i $SLAVE_LIST -e '1d'
	wait
	echo $CHK_TARGET| xargs -I fname sed -i $SLAVE_LIST -e 's/^fname$//g' -e '/^$/d'
	wait
	echo $CHK_TARGET >> $FIN_LIST
	wait
	CHK_TARGET=`cat $SLAVE_LIST|sed -n -e '1p'`
done
cat $FIN_LIST > $CHK_LIST
wait


CHK_TARGET=`cat $X18_LIST|tee $SLAVE_LIST|sed -n -e '1p'`
rm $FIN_LIST 2>/dev/null
while [ "$CHK_TARGET" != "" ]
do
	CHK_TARGET=`cat $SLAVE_LIST|sed -n -e '1p'`
	sed -i $SLAVE_LIST -e '1d'
	wait
	echo $CHK_TARGET| xargs -I fname sed -i $SLAVE_LIST -e 's/^fname//g' -e '/^$/d'
	wait
	echo $CHK_TARGET >> $FIN_LIST
	wait
	CHK_TARGET=`cat $SLAVE_LIST|sed -n -e '1p'`
done
cat $FIN_LIST > $X18_LIST

rm $SLAVE_LIST $FIN_LIST 2>/dev/null
wait
