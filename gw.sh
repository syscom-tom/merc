#!/bin/bash
# Program:
# 	merc guild war action of all guild members
# History:
# 2018/04/14	First release

# define var
HOST_MERC_DIR="/home/kiosk/merc"
source "$HOST_MERC_DIR/var.list";
UASAGE="usage: gw-support.sh [-p1 -p2 -p3 -p4] [-f] [--pray]"
POS="-p1"
FILL_UP=false
PRAY=false

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
	-f) # fill up bp with guild pool
		FILL_UP=true;
	;;
	--pray) # pray mode
		PRAY=true;
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
$ADB_CMD root # need check success
$ADB_CMD connect 192.168.122.48:5555
# perform 
if [ "$FILL_UP" = true ] && [ "$PRAY" = true ]; then # maybe fill bp with spring water
	echo "not implementation";
	$ADB_CMD shell poweroff;
	exit;
elif [ "$PRAY" = true ]; then # maybe change
	for I in `echo $GUILD_MEMBERS`; do
		if [ ! -f "$HOST_MERC_DIR/account/$I" ]; then echo "$HOST_MERC_DIR/account/$I not exist. please check member list."; exit 1; fi;
		#/bin/sh $HOST_MERC_DIR/gw-tap.sh -a "$I" -c 20 --pray "$POS" # pray 300 bp
		/bin/sh $HOST_MERC_DIR/gw-tap.sh -a "$I" -c 10 --pray "$POS" # pray 150 bp
	done;
	$ADB_CMD shell poweroff;
	exit;
elif [ "$FILL_UP" = true ]; then
	for I in `echo $GUILD_MEMBERS`; do
		if [ ! -f "$HOST_MERC_DIR/account/$I" ]; then echo "$HOST_MERC_DIR/account/$I not exist. please check member list."; exit 1; fi;
		/bin/sh $HOST_MERC_DIR/gw-tap.sh -a "$I" -c 20 -f guild "$POS" # fill up bp & support 500 bp
	done;
	$ADB_CMD shell poweroff;
	exit;
fi;
for I in `echo $GUILD_MEMBERS`; do # basic
	if [ ! -f "$HOST_MERC_DIR/account/$I" ]; then echo "$HOST_MERC_DIR/account/$I not exist. please check member list."; exit 1; fi;
	/bin/sh $HOST_MERC_DIR/gw-tap.sh -a "$I" -c 20 "$POS" # support 500 bp
done;
$ADB_CMD shell poweroff;
