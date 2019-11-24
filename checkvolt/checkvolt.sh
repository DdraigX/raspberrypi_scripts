
#!/bin/bash

tail -fn0 /var/log/syslog | \
while read line ; do
        echo "$line" | grep "Under-voltage"
        if [ $? = 0 ]
        then
                echo "Time: $(date) !!Detected Under-Voltage" >> /home/pi/voltlog.log
                xmessage -center -timeout 60 "UnderVoltage, Check Battery, Powering Down"
                sleep 10
                sudo shutdown -h now #Modify this line to add additional commands. 
        fi
done
