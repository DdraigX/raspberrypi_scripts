#!/bin/bash

# The purpose of this script is to periodically ping an external IP and an 
# internal IP, and if they're down, then shutdown the system.

check_interval=3h
external_ip="1.1.1.1"
internal_ip="192.168.1.1"

outage="FALSE"

function func_ping() {
	ping $1 -c 3 -q > /dev/null
	return $?
}

while true; do
	# This is the interval at which we're going to check. 
	# Could be at the bottom.  Doesn't matter.
	sleep $check_interval

	# Ping the external IP.
	for (( i=0; i<=5; i++ ))
	do
		func_ping $external_ip 
		sleep 30s
		# If it's down, then set the outage flag.
		if [ "$?" != "0" ]; then
			echo "$(date) : Failed to Ping $external_ip" >> /var/log/netlog.log
			outage="TRUE"
			echo $i
		else
			echo "$(date) : Ping success : $external_ip" >> /var/log/netlog.log
			# seting back to FALSE here in case the IP came back
			# since our last check
			outage="FALSE"

		fi
	done

	# If the outage flag is true, then we'll check the internal
	# IP address.  No use in checking it every time if BOTH are 
	# needed to be true in order to shut the system down.
	if [ "$outage" == "TRUE" ]; then

		for (( i=0; i<=5; i++ ))
		do
			func_ping $internal_ip
			sleep 30s
			if [ "$?" != "0" ]; then 
				echo "$(date) : Internal IP down." >> /var/log/netlog.log
				# Not really necessary, but it's here for clarity.
				outage="TRUE"
			else
				#echo "continue looping"
				#in order to continue looping, we'll set the outage flag back to 0
				outage="FALSE"
			fi
		done
	fi

	# The final decision
	if [ "$outage" == "TRUE" ]; then
		echo "shutdown initiated" >> /var/log/netlog.log
	fi
done
