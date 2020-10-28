Every 3 hours this checks for outside network connection and an internal connection. Then shuts down the raspberry pi if no connections are found. 

Change the below variables to fit your needs:
check_interval=3h
external_ip="1.1.1.1"
internal_ip="192.168.1.1"
