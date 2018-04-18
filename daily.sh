#!/bin/bash
# Program:
# 	merc daily sign in 
# History:
# 2018/04/14	First release

# define var
HOST_MERC_DIR="/home/kiosk/merc"
source "$HOST_MERC_DIR/var.list";

# perpare 
$ADB_CMD connect 192.168.122.48:5555
#ID=echo "$ADB_CMD shell id|cut -d '(' -f1"; echo "adb shell $ID";
#while [ "$ID" != "uid=0" ]; do # check success
	$ADB_CMD root 
	$ADB_CMD connect 192.168.122.48:5555
#	ID=$ADB_CMD shell "id|cut -d '(' -f1";
#	echo "$ID";
#done;

### for guild members
echo "=== guild member sign in ===";
for I in `echo $GUILD_MEMBERS`; do 
	echo "$(date +%Y/%m/%d\ %H:%M) $I";
	if [ ! -f "$HOST_MERC_DIR/account/$I" ]; then echo "$HOST_MERC_DIR/account/$I not exist. please check member list."; exit 1; fi; # check parameters
	$ADB_CMD push "$HOST_MERC_DIR/account/$I" /data/data/jp.co.happyelements.toto/shared_prefs/jp.co.happyelements.toto.v2.playerprefs.xml 1>/dev/null;
# sign in
	$ADB_CMD shell input tap 550 300 # tap merc icon
	$ADB_CMD shell 'for i in `seq 1 1 22`; do input tap 1200 700; done'
	$ADB_CMD shell input tap 1150 750 # button_log
	#for n in `seq 1 1 50`; do $ADB_CMD shell input tap 800 50; done; # button_log_救援
	$ADB_CMD shell input tap 800 50 # button_log_救援
	$ADB_CMD shell input tap 1200 120 # button_log_救援scroll_top
	$ADB_CMD shell input tap 1050 240 # button_log_救援1
	$ADB_CMD shell input tap 800 600 # button_Y/N-Y
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell input tap 1050 450 # button_log_救援2
	$ADB_CMD shell input tap 800 600 # button_Y/N-Y
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell input tap 1050 620 # button_log_救援3
	$ADB_CMD shell input tap 800 600 # button_Y/N-Y
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell "ps|grep happyelement|cut -d ' ' -f5|xargs kill" # stop merc 
done;
### for all account
echo "=== all account sign in ==="; 
for I in `ls $HOST_MERC_DIR/account/`; do 
	echo "$(date +%Y/%m/%d\ %H:%M) $I";
	$ADB_CMD push "$HOST_MERC_DIR/account/$I" /data/data/jp.co.happyelements.toto/shared_prefs/jp.co.happyelements.toto.v2.playerprefs.xml 1>/dev/null;
# sign in
	$ADB_CMD shell input tap 550 300 # tap merc icon
	$ADB_CMD shell 'for i in `seq 1 1 22`; do input tap 1200 700; done'
	$ADB_CMD shell input tap 1150 750 # button_log
	#for n in `seq 1 1 50`; do $ADB_CMD shell input tap 800 50; done; # button_log_救援
	$ADB_CMD shell input tap 800 50 # button_log_救援
	$ADB_CMD shell input tap 1200 120 # button_log_救援scroll_top
	$ADB_CMD shell input tap 1050 240 # button_log_救援1
	$ADB_CMD shell input tap 800 600 # button_Y/N-Y
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell input tap 1050 450 # button_log_救援2
	$ADB_CMD shell input tap 800 600 # button_Y/N-Y
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell input tap 1050 620 # button_log_救援3
	$ADB_CMD shell input tap 800 600 # button_Y/N-Y
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell input tap 1100 50 # button_log_close
	$ADB_CMD shell input tap 100 750 # button_home
	$ADB_CMD shell input tap 100 380 # button_gift
	$ADB_CMD shell input tap 100 380 # button_gift
	$ADB_CMD shell input tap 500 50 # button_accept_gift
	$ADB_CMD shell input tap 500 50 # button_accept_gift
	$ADB_CMD shell input tap 800 600 # button_Y/N-Y
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell "ps|grep happyelement|cut -d ' ' -f5|xargs kill" # stop merc 
done;
$ADB_CMD shell poweroff; # poweroff vm


