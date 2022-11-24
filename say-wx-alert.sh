#!/bin/bash
# 
# This is an example script showing how you would push 
# announcements out rather than using a tail message
# this would send out an alert at a given interval 
# regardless of whether anyone keyed the system.
# Set the interval in seconds.

# call say-wx-alert.sh with no parameters for single playing
# call with parameter 'C' for continuous play at interval. Can be 
# run in the background. Control C or kill job to stop.
# If there is no current alert it will not play.
#
# Cutomize as you wish
#
# WA3DSP 3/2017

script_dir=$(dirname "$0")
source "$script_dir/AutoSky.ini"

Interval="600" # every ten minutes

node=$NODE1

alertsize=`du -b "$TMPDIR/WXA/wx-tail.wav" | cut -f1`

#echo $alertsize, $node

if [ "$alertsize" -gt "3000" ]
    then
	rm -f $TMPDIR/tmp-tail.wav
	sox $BASEDIR/SOUNDS/silence1.wav $TMPDIR/WXA/wx-tail.wav $TMPDIR/tmp-tail.wav
	
	if [[ "${1^}" = "C" ]] 
		then
#			echo "Continuous"
			while :
			do
			# Give ID - not necessary in most cases - system ID's
			# Uncomment next line for ID - Gives IP every X intervals
				/usr/bin/asterisk -rx "rpt fun $node *80"
				X=5
				for (( i=0; i<X; i++ )) ;
				do	
					/usr/bin/asterisk -rx "rpt localplay $node $TMPDIR/tmp-tail"
					sleep $Interval
				done
			done
	else
		/usr/bin/asterisk -rx "rpt localplay $node $TMPDIR/tmp-tail"
	fi
else

echo "No Alerts"

fi

