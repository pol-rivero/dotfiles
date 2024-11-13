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

interface_names=$(ip -o link show | awk -F': ' '{print $2}')
# Prioritize and get the IP address in order of VPN > Ethernet > WiFi
vpn_interfaces=$(echo "$interface_names" | grep -E '^(tun|tap|ipsec|ppp|vtun|openvpn|wg|wireguard)')
if [ -n "$vpn_interfaces" ]; then
    get_ip  $vpn_interfaces
fi

ethernet_interfaces=$(echo "$interface_names" | grep -E '^(eth|enx|enp)')
if [ -n "$ethernet_interfaces" ]; then
    get_ip  $ethernet_interfaces
fi

wifi_interfaces=$(echo "$interface_names" | grep -E '^(wlan|wlo)')
if [ -n "$wifi_interfaces" ]; then
    get_ip  $wifi_interfaces
fi

echo "No active network interface found with an IP address."
exit 1
