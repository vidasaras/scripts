#!/bin/sh

# Get initial RX and TX bytes
start_rx=$(cat /sys/class/net/wlan0/statistics/rx_bytes)
start_tx=$(cat /sys/class/net/wlan0/statistics/tx_bytes)

echo "Press Enter to stop and calculate bandwidth usage..."

# Wait for the user to press Enter
# sleep 1
read -r _

# Get final RX and TX bytes
end_rx=$(cat /sys/class/net/wlan0/statistics/rx_bytes)
end_tx=$(cat /sys/class/net/wlan0/statistics/tx_bytes)

# Calculate the difference
rx_diff=$((end_rx - start_rx))
tx_diff=$((end_tx - start_tx))
total_diff=$((rx_diff + tx_diff))

# Convert bytes to megabytes
rx_mb=$(echo "scale=2; $rx_diff / 1024 / 1024" | bc)
tx_mb=$(echo "scale=2; $tx_diff / 1024 / 1024" | bc)
total_mb=$(echo "scale=2; $total_diff / 1024 / 1024" | bc)

# Print the results
echo "Bandwidth usage:"
echo "Downloaded: ${rx_mb} MB"
echo "Uploaded: ${tx_mb} MB"
echo "Total: ${total_mb} MB"
