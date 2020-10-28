
#!/bin/bash

while :
do
                { echo -n "Time: $(date)  " && echo "Temp: $(vcgencmd measure_temp)"; } >> /var/log/temp_output.log
                sleep 10m
done
