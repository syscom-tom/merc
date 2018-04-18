#!/bin/bash
# Program:
# 	merc guild war tap step
# History:
# 2018/04/14	First release

# define var
ADB_CMD="/home/kiosk/platform-tools/adb"
HOST_MERC_DIR="/home/kiosk/merc"
UASAGE="usage: gw-tap.sh -a <account code> [-p1 -p2 -p3 -p4] [-c <count>] [--pray] [-f | --fill-bp <guild|bottle|spring>]";
GPOS_X="450" # guild pos_x 1
GPOS_Y="150" # guild pos_y 1
TAP_X="500" # gw_support X
#TAP_Y="400" # gw_support Y
C="1" # tap count
FILL_UP="none" # use guild bp pool, bp bottle, spring water

# parameters pass var
while [ "$1" != "" ]; do
	case $1 in
	-a) # account
		shift
		ACCOUNT="$1";
	;;
	-p1) # guild position 1
	;;
	-p2) # guild position 2
		GPOS_Y="450"
	;;
	-p3) # guild position 3
		GPOS_X="200"
		GPOS_Y="450"
	;;
	-p4) # guild position 4
		GPOS_X="200"
	;;
	--pray) # pray mode
		TAP_X="200" # gw_pray X
		#TAP_Y="400" # gw_pray Y
	;;
	-f|--fill-bp) # fill up bp 
		shift
		FILL_UP="$1"; 
	;;
	-c) # count
		shift
		C="$1";
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
# check parameters # error msg
if [ "$FILL_UP" != "guild" ] && [ "$FILL_UP" != "bottle" ] && [ "$FILL_UP" != "spring" ] && [ "$FILL_UP" != "none" ]; then echo "$UASAGE"; exit 1; fi;
if [ ! -f "$HOST_MERC_DIR/account/$ACCOUNT" ]; then echo "$HOST_MERC_DIR/account/\"$ACCOUNT\" not exist. please check member list."; exit 1; fi;
echo "$ACCOUNT tap ($GPOS_X,$GPOS_Y),$TAP_X * $C (full bp with $FILL_UP)";
# perform tap step
$ADB_CMD push "$HOST_MERC_DIR/account/$ACCOUNT" /data/data/jp.co.happyelements.toto/shared_prefs/jp.co.happyelements.toto.v2.playerprefs.xml 1>/dev/null
$ADB_CMD shell input tap 550 300 # tap merc icon
$ADB_CMD shell 'for i in `seq 1 1 20`; do input tap 1200 700; done'
if [ "$FILL_UP" = "bottle" ]; then # fill up bp with bp bottle
	echo "fill up bp with bp bottle method not implementation"; # not sure position of bp bottle
	exit;
fi;
if [ "$FILL_UP" = "spring" ]; then # fill up bp with spring water
	$ADB_CMD shell input tap 100 300 # button_spring
	ping 127.0.0.1 -c 3 1> /dev/null # wait loading
	$ADB_CMD shell input tap 100 300 # any tap
	$ADB_CMD shell input tap 800 600 # button_Y/N-Y
	exit;
fi;
$ADB_CMD shell input tap 550 750 # button_guild
#$ADB_CMD shell input tap 550 750 # button_guild
ping 127.0.0.1 -c 3 1> /dev/null # wait loading
if [ "$FILL_UP" = "guild" ]; then # fill up bp with guild bp pool
	$ADB_CMD shell input tap 550 600 # button_guild_bp
	$ADB_CMD shell input tap 800 600 # button_Y/N-Y
	$ADB_CMD shell input tap 600 600 # button_OK 
fi;
$ADB_CMD shell input tap "$GPOS_X" "$GPOS_Y" # tap gulid pos
let C="$C"-1;
for I in `seq 1 1 $C`; do 
	$ADB_CMD shell input tap "$TAP_X" 400
	if [ "$C" -gt "$I" ]; then ping 127.0.0.1 -c 7 1> /dev/null; done;
done;
#$ADB_CMD shell input tap "$TAP_X" 400
$ADB_CMD shell "ps|grep happyelement|cut -d ' ' -f5|xargs kill" # stop merc

