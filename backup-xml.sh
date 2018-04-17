#!/bin/bash
# Program:
# 	backup merc playerprefs.xml to localhos
# History:
# 2018/04/14	First release

# define var
ADB_CMD="/home/kiosk/platform-tools/adb"
HOST_MERC_DIR="/home/kiosk/merc"
ACCOUNT_LIST="zo8kpzcave"

for I in `echo $ACCOUNT_LIST`; do echo "$I" ;
	$ADB_CMD shell input tap 550 300 # tap merc icon
	$ADB_CMD shell 'for i in `seq 1 1 10`; do input tap 200 750; done' # button_機種變更
	$ADB_CMD shell input tap 600 500 # 引繼碼
	$ADB_CMD shell input text "$I";
	$ADB_CMD shell input tap 600 550 # pw
	$ADB_CMD shell input tap 600 550 # pw
	$ADB_CMD shell input text "00000000";
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell input tap 600 700 # button_引繼
	$ADB_CMD shell input tap 600 600 # button_OK
	$ADB_CMD shell input tap 800 600 # button_Y/N-Y
	$ADB_CMD pull /data/data/jp.co.happyelements.toto/shared_prefs/jp.co.happyelements.toto.v2.playerprefs.xml "$HOST_MERC_DIR/account/$I" 1>/dev/null
	$ADB_CMD shell "sh /data/data/merc/stop.sh" # stop merc 
done;
