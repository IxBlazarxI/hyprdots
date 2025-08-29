#!/bin/bash

# You can modify 'tun0' if your VPN uses another interface like 'tun1' or 'wg0'
if ip link show tun0 > /dev/null 2>&1; then
  echo "VPN connected"
  exit 0  # success
else
  echo "No VPN"
  exit 1  # failure = shows alt text
fi
