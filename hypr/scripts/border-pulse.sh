#!/usr/bin/zsh

while true; do
  hyprctl keyword col.active_border "rgba(68ebffff) rgba(43a1b5ff) rgba(1d566aff) 45deg"
  sleep 1
  hyprctl keyword col.active_border "rgba(68ebff44) rgba(43a1b544) rgba(1d566a44) 45deg"
  sleep 1
done
