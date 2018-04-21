#!/bin/bash
# Program:
# 	merc 暴走活動 guild support 
# History:
# 2018/04/14	First release

# define var
HOST_MERC_DIR="/home/kiosk/merc"
source "$HOST_MERC_DIR/var.list";
UASAGE=""
POS="330"


# parameters pass var
while [ "$1" != "" ]; do
	case $1 in
	-p1) # guild position 1
		POS="330"
	;;
	-p2) # guild position 2
		POS="530"
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
for I in `echo $GUILD_ONE`; do # guild-one support
	if [ ! -f "$HOST_MERC_DIR/account/$I" ]; then echo "$HOST_MERC_DIR/account/$I not exist. please check member list."; exit 1; fi;
	echo "$I";
	$ADB_CMD push "$HOST_MERC_DIR/account/$I" /data/data/jp.co.happyelements.toto/shared_prefs/jp.co.happyelements.toto.v2.playerprefs.xml 1>/dev/null # change account 	
	$ADB_CMD shell input tap 550 300 # tap merc icon
	$ADB_CMD shell 'for i in `seq 1 1 20`; do input tap 1200 700; done'
# tap step
	$ADB_CMD shell input tap 950 400 # banner_event1
	ping 127.0.0.1 -c 3 1> /dev/null # wait loading
	$ADB_CMD shell input tap 750 100 # event1_guild_support
	$ADB_CMD shell input tap 1100 "$POS" # event1_support_pos1 or 2
	ping 127.0.0.1 -c 3 1> /dev/null # wait loading
	$ADB_CMD shell input tap 120 330 # event1_急擊
	$ADB_CMD shell input tap 800 580 # button_event1_go
	ping 127.0.0.1 -c 11 1> /dev/null # *wait loading*
	$ADB_CMD shell input tap 800 580 # any tap
	$ADB_CMD shell input tap 800 580 # any tap
	ping 127.0.0.1 -c 6 1> /dev/null # wait loading
	$ADB_CMD shell input tap 100 100 # button_battle_stop
	$ADB_CMD shell input tap 850 600 # button_battle_lose
	$ADB_CMD shell input tap 800 600 # button_Y/N-Y
	ping 127.0.0.1 -c 3 1> /dev/null # wait loading
# kill merc app
	$ADB_CMD shell "ps|grep happyelement|cut -d ' ' -f5|xargs kill" # stop merc
done;
#$ADB_CMD shell poweroff;

