ip link add name br0 type bridge
ip link set dev br0 up
iw dev wlan0 set 4addr on
ip link set dev wlan0 master br0
dhcpcd br0

