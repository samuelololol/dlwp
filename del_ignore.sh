#!/bin/bash
./chk_duplicate.sh
wait

RAMDISK_DIR=/dev/shm

# for delete file list
COMM_ROOT_DIR=/home/samuel/commands/dynamic_wallpapers
WALLPAPER_DIR=/home/samuel/commands/dynamic_wallpapers/wallpapers
WALPAPER_LIST=$RAMDISK_DIR/wallpaper_templist
ENCODE_URI=/home/samuel/commands/dynamic_wallpapers/uriencode.sh

# for delete file
DIGNORE=/home/samuel/commands/dynamic_wallpapers/ignore_list
TIGNORE=$RAMDISK_DIR/temp_ignore_list

# for 18 file
X18_LIST=/home/samuel/commands/dynamic_wallpapers/18x_list
T18=$RAMDISK_DIR/temp_18x_list


cp -f $DIGNORE  $TIGNORE
wait
cp -f $X18_LIST  $T18
wait

EXIST_FILES=$RAMDISK_DIR/exist_files
ls -c $WALLPAPER_DIR > $EXIST_FILES
wait
EF_LINENUMBER=`wc -l $EXIST_FILES|awk '{print $1}'`
wait

DIGNORE_LINENUMBER=`wc -l $DIGNORE|awk '{print $1}'`
wait
X18_LIST_LINENUMBER=`wc -l $X18_LIST|awk '{print $1}'`
wait
#echo "debug: $X18_LIST_LINENUMBER"
if [ "$#" == 0 ]; then
	echo "./del_ignore.sh [flag] [option]"
	echo 
	echo "[flags]"
	echo " -d: Delete all ignore"
	echo " -l  [option]"
	echo "      option:" 
	echo "          custion list file you want to modify"
	echo " -m  [option]"
	echo "      option:"
	echo "          folder you want to move to"
	echo " all: move and delete"
	exit 1

elif [ "$#" == 1 ] && [ "$1" == "-d" ]; then
	echo "Delete Ignore File"
	for indx in $(seq $DIGNORE_LINENUMBER)
	do
		filename=`cat $TIGNORE | sed -n -e '$p'` 
		wait
		# delete file
		rm "$WALLPAPER_DIR/$filename" 2> /dev/null
		if [ "$?" == 0 ]; then
			echo "Delete $target/$filename"
		fi

		sed -i $TIGNORE -e '1d'
		wait
	done
	wait
	$COMM_ROOT_DIR/reflesh_list.sh
	wait

elif [ "$#" == 2 ] && [ "$1" == "-m" ]; then
	echo "Move File"
	echo 
	if [ "$2" = "18x" ]; then
		for indx in $(seq $X18_LIST_LINENUMBER)
		do
			filename=`cat $T18 | sed -n -e '$p'` 
			wait
			# delete list
			$ENCODE_URI $filename| xargs -I urifilename sed -i $WALPAPER_LIST -e 's/^.*urifilename.*$//g' -e '/^$/d'
			wait


			# move file
			mkdir "$COMM_ROOT_DIR/$2" 2> /dev/null
			wait
			mv "$WALLPAPER_DIR/$filename" "$COMM_ROOT_DIR/$2" 2>/dev/null
			if [ "$?" == 0 ]; then
				echo "Move $target/$filename to $COMM_ROOT_DIR/$2"
			fi
			wait

			sed -i $T18 -e '1d'
			wait
		done
		wait
	fi
	wait
	$COMM_ROOT_DIR/reflesh_list.sh
	wait


elif [ "$#" == 1 ] && [ "$1" == "all" ]; then

	# delete
	for dindx in $(seq $DIGNORE_LINENUMBER)
	do
		filename=`cat $TIGNORE | sed -n -e '1p'` 
		wait
		# delete list
		$ENCODE_URI $filename| xargs -I urifilename sed -i $WALPAPER_LIST -e 's/^.*urifilename.*$//g' -e '/^$/d'
		wait

		# delete file
		rm "$WALLPAPER_DIR/$filename" 2> /dev/null
		if [ "$?" == 0 ]; then
			echo "Delete $filename on list($WALPAPER_LIST)"
		fi
		wait

		sed -i $TIGNORE -e '1d'
		wait
	done
	wait

	# 18x move
	for mindx in $(seq $X18_LIST_LINENUMBER)
	do
		filename=`cat $T18 | sed -n -e '1p'` 
		wait
		# delete list
		$ENCODE_URI $filename| xargs -I urifilename sed -i $WALPAPER_LIST -e 's/^.*urifilename.*$//g' -e '/^$/d'
		wait
		#echo "Delete $filename on list($WALPAPER_LIST)"


		# move file
		mkdir "$COMM_ROOT_DIR/18x" 2> /dev/null
		wait
		mv "$WALLPAPER_DIR/$filename" "$COMM_ROOT_DIR/18x" 2> /dev/null
		if [ "$?" == 0 ]; then
			echo "Move $target/$filename to $COMM_ROOT_DIR/18x"
		fi
		wait

		sed -i $T18 -e '1d'
		wait
	done
	wait
	$COMM_ROOT_DIR/reflesh_list.sh
	wait






# FOR EXTERNAL LIST USE

# this is for uplink.sh to clean the duplicate link
elif [ "$#" == 2 ] && [ "$1" == "-l" ] ; then
	# delete 
	for dindx in $(seq $DIGNORE_LINENUMBER)
	do
		dfilename=`cat $TIGNORE | sed -n -e '1p'` 
		wait
		# delete list
		$ENCODE_URI $dfilename| xargs -I urifilename sed -i $2 -e 's/^.*urifilename.*$//g' -e '/^$/d'
		wait
		#echo "Delete $dfilename on list($2)"

		sed -i $TIGNORE -e '1d' 
		wait
	done
	wait
	# 18x
	for mindx in $(seq $X18_LIST_LINENUMBER)
	do
		mfilename=`cat $T18 | sed -n -e '1p'` 
		wait
		# delete list
		$ENCODE_URI $mfilename| xargs -I urifilename sed -i $2 -e 's/^.*urifilename.*$//g' -e '/^$/d'
		wait
		#echo "Delete $mfilename on list($2)"

		sed -i $T18 -e '1d'
		wait
	done
	wait
	for eindx in $(seq $EF_LINENUMBER)
	do
		efilename=`cat $EXIST_FILES | sed -n -e '1p'` 
		wait
		# delete list
		$ENCODE_URI $efilename| xargs -I urifilename sed -i $2 -e 's/^.*urifilename.*$//g' -e '/^$/d'
		wait
		#echo "Delete $efilename on list($2)"

		sed -i $EXIST_FILES -e '1d' 
		wait
	done
	wait


else
	echo "Error: wrong arguments"
	exit 1
fi
rm $EXIST_FILES $T18 $TIGNORE
wait
exit 0
