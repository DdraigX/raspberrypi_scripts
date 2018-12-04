
#!/bin/bash

while :
do
                { echo -n "Time: $(date)  " && echo "Temp: $(vcgencmd measure_temp)"; } >> /home/pi/temp_output.log
                sleep 1m
done
