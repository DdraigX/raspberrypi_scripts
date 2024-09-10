#!/bin/bash


LOCALNETWORKIP=192.168.1.1
REMOTENETWORKIP=1.1.1.1

STATEUP=0
STATEDOWN=0
REMOTESTATE=0
LOCALSTATE=0


while true; do  #Main Loop
	sleep 6h
	for (( i=0; i<=5; i++ ))  #Loop1
	do
		ping -q -c5 $REMOTENETWORKIP > /dev/null
		if [ $? -eq 0 ]; then
			STATEUP=$((STATEUP+1))
			sleep 10m
		else
			STATEDOWN=$((STATEDOWN+1))
			sleep 1m
			if [ $STATEDOWN -eq 5 ]; then
				echo "Remote network down at $(date)" >> /home/pi/netlog.log
				REMOTESTATE=1
				echo "$REMOTESTATE"
				break
			fi
		fi
	done #Loop1
        
	if [ $REMOTESTATE -eq 1 ]; then
		STATEDOWN=0
		STATEUP=0
		for (( i=0; i=5; i++ )) #Loop2 
		do
			ping -q -c5 $LOCALNETWORKIP > /dev/null
			if [ $? -eq 0 ]; then #missing then
			STATEDOWN=0
			STATEUP=0
			for (( i=0; i=5; i++ )); # Loop3
			do  
				ping -q -c5 $LOCALNETWORKIP > /dev/null
				if [ $? -eq 0 ]; then
					STATEUP=$((STATEUP+1))
					sleep 10m
				else
					STATEDOWN=$((STATEDOWN+1))
					sleep 1m
					if [ $STATEDOWN -eq 5 ]; then
						echo "Local network down at $(date)" >> /home/pi/netlog.log
						LOCALSTATE=1
						sleep 10m
					fi #added by will
				elif
					STATEDOWN=$((STATEDOWN+1))
					sleep 1m
					if [ $STATEDOWN -eq 5 ]; then
						echo "Local network down at $(date)" >> /home/pi/netlog.log
						LOCALSTATE=1
						break
					fi
				fi
			done #Loop3 added by will
		done #Loop2
	fi

	if [ $REMOTESTATE -eq 1 -a $LOCALSTATE -eq 1 ]; then
		echo "Shutting System Down at $(date)" >> /home/pi/netlog.log
		sudo shutdown -h now
		break
	fi

done #Main Loop
