#!/bin/bash
#
##
## This is AutoSkyWarn 3 Version 170322
## Written by KF5VH - Steve Mahler
## Permission to use requires that the above
##  credit is maintained in all Shell Scripts.
##
#
##################################################################
#
# description:  Type a RPT FUN NODE Cmd from Shell Prompt
#
# 10/16/2016    Version 1.0 SJM - KF5VH initial attempt
# 10/17/2016    Version 1.1 SJM - KF5VH added "auto-STAR"
#
##################################################################

if [ -f /usr/local/etc/allstar.env ] ; then
    source /usr/local/etc/allstar.env
else
    echo  "Error! Missing Allstar Environment file (/usr/local/etc/allstar.env), Aborting..." 
    exit
fi



# set -x
set -o noglob

WORK=/tmp

cd $WORK

if [ $# -ne 1 ]; then
  /bin/echo "RPT: must have exactly one paramter"
  exit 0
fi

CMD="$1"
FC="${CMD:0:1}"
FIXED=$CMD
STAR="*"
# echo Entire ... "$CMD"
# echo Cut ...... "$FC"
# echo Fixed .... "$FIXED"
# echo Star ..... "$STAR"

if [ $FC !=  $STAR ]; then
  FIXED=$STAR$CMD
fi

#echo Fixed .... "$FIXED"

/usr/sbin/asterisk -rx "rpt fun $NODE1 $FIXED " 2>>/dev/null


