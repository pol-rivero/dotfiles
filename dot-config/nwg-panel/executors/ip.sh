#!/bin/bash

get_ip() {
	prefix=$1
	shift
    for iface in "$@"; do
        # Check if the interface is up and has an IP address
        if ip link show "$iface" | grep -q "state UP"; then
            ip_address=$(ip -o -4 addr show "$iface" | awk '{print $4}' | cut -d/ -f1)
            if [ -n "$ip_address" ]; then
                echo "$prefix $ip_address"
                exit 0
            fi
        fi
    done
}

vpn_interfaces=$(ip -o link show | awk -F': ' '{print $2}' | grep -E '^(ppp|tun|tap|wg)')

ethernet_interfaces=$(ip -o link show | awk -F': ' '{print $2}' | grep -E '^(eth|enx|enp)')

wifi_interfaces=$(ip -o link show | awk -F': ' '{print $2}' | grep -E '^(wlan|wlo)')

# Prioritize and get the IP address in order of VPN > Ethernet > WiFi
if [ -n "$vpn_interfaces" ]; then
    get_ip  $vpn_interfaces
fi

if [ -n "$ethernet_interfaces" ]; then
    get_ip  $ethernet_interfaces
fi

if [ -n "$wifi_interfaces" ]; then
    get_ip  $wifi_interfaces
fi

echo "No active network interface found with an IP address."
exit 1
