#!/bin/bash
# Program:
# 	update merc playerprefs.xml to localhos
# History:
# 2018/04/14	First release

# define var
HOST_MERC_DIR="/home/kiosk/merc"
source "$HOST_MERC_DIR/var.list";
ACCOUNT_LIST="zo8kpzcave"

for I in `echo $ACCOUNT_LIST`; do echo "$I" ;
	if [ ! -f "$HOST_MERC_DIR/account/$I" ]; then echo "$HOST_MERC_DIR/account/\"$I\" not exist. please check member list."; exit 1; fi;
	$ADB_CMD push "$HOST_MERC_DIR/account/$I" /data/data/jp.co.happyelements.toto/shared_prefs/jp.co.happyelements.toto.v2.playerprefs.xml
	# action
$ADB_CMD shell input tap 550 300 # tap merc icon
$ADB_CMD shell 'for i in `seq 1 1 18`; do input tap 1200 700; done'
	$ADB_CMD shell input tap 100 300 # button_spring
	ping 127.0.0.1 -c 3 1> /dev/null # wait loading
	for t in `seq 1 1 10`; do $ADB_CMD shell input tap 100 300 # any tap
	$ADB_CMD shell input tap 100 750 # button_home
	$ADB_CMD shell input tap 1150 750 # button_log
	done; # done
	$ADB_CMD pull /data/data/jp.co.happyelements.toto/shared_prefs/jp.co.happyelements.toto.v2.playerprefs.xml "$HOST_MERC_DIR/account/$I"
	$ADB_CMD shell "sh /data/data/merc/stop.sh" # stop merc 
done;
