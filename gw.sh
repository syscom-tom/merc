#!/bin/bash
# Program:
# 	merc guild war action of all guild members
# History:
# 2018/04/14	First release

# define var
HOST_MERC_DIR="/home/kiosk/merc"
source "$HOST_MERC_DIR/var.list";
UASAGE="usage: gw-support.sh [-p1 -p2 -p3 -p4] [-m spring|guild-bp-support|support]"
POS="-p1"
MODE="none"

# parameters pass var
while [ "$1" != "" ]; do
	case $1 in
	-p1) # guild position 1
		POS="-p1"
	;;
	-p2) # guild position 2
		POS="-p2"
	;;
	-p3) # guild position 3
		POS="-p3"
	;;
	-p4) # guild position 4
		POS="-p4"
	;;
	-m) # mode spring only, pool and support, pray, support only
		shift
		case $1 in
			spring) # spring only
				MODE="$1"
				F="spring"
				C="0"
			;;
			guild-bp-support) # pool bp and support 
				MODE="$1"
				F="guild"
				C="20"
			;;
			support) # support only
				MODE="$1"
				F="none"
				C="20"
			;;
			*)
				echo "$UASAGE";
			;;
		esac
	;;
	-h | --help )
		echo "$UASAGE";
		exit
	;;
	* )
		echo "$UASAGE";
		exit 1
	esac
	shift
done
# check parameters

# perpare 
$ADB_CMD connect 192.168.122.48:5555
ID=`/home/kiosk/platform-tools/adb shell id|cut -d '(' -f1`; echo "adb shell $ID";
while [ "$ID" != "uid=0" ]; do # check success
	$ADB_CMD root # need check success
	$ADB_CMD connect 192.168.122.48:5555
	ID=`/home/kiosk/platform-tools/adb shell id|cut -d '(' -f1`; echo "adb shell $ID";
done;

# perform
# according mode type GUILD_PIONEER and ONE do different, maybe
for I in `echo $GUILD_MEMBERS`; do # basic
	if [ ! -f "$HOST_MERC_DIR/account/$I" ]; then echo "$HOST_MERC_DIR/account/$I not exist. please check member list."; exit 1; fi;
	/bin/sh $HOST_MERC_DIR/gw-tap.sh -a "$I" -c "$C" -f "$F" "$POS" # support 500 bp
done;
$ADB_CMD shell poweroff;
