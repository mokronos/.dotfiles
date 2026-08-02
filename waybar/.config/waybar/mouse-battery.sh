#!/usr/bin/env bash
set -euo pipefail

disconnected() {
  jq -cn --arg text $'\U000f037e' \
    '{text: $text, class: "disconnected", tooltip: "Mouse disconnected"}'
}

is_wired_mouse_connected() {
  for device in /sys/bus/usb/devices/*; do
    [[ -r $device/idVendor && -r $device/idProduct ]] || continue
    [[ $(<"$device/idVendor") == "046d" ]] || continue
    [[ $(<"$device/idProduct") == "c098" ]] && return 0
  done

  return 1
}

for battery in /sys/class/power_supply/hidpp_battery_*; do
  [[ -d $battery && -r $battery/capacity ]] || continue

  capacity="$(<"$battery/capacity")"
  [[ $capacity =~ ^[0-9]+$ ]] || continue

  status="unknown"
  if [[ -r $battery/status ]]; then
    status="$(<"$battery/status")"
  fi

  charging=false
  if is_wired_mouse_connected; then
    charging=true
  elif [[ $status == "Unknown" ]]; then
    continue
  elif [[ $status == "Charging" ]]; then
    charging=true
  fi

  model="$(<"$battery/model_name")"
  text=$'\U000f037d'
  text+=" $capacity%"
  if [[ $charging == true ]]; then
    jq -cn --arg text "$text" --arg model "$model" --arg capacity "$capacity" \
      '{text: $text, class: "charging", tooltip: ($model + " battery: " + $capacity + "% (charging)")}'
  else
    jq -cn --arg text "$text" --arg model "$model" --arg capacity "$capacity" \
      '{text: $text, class: "connected", tooltip: ($model + " battery: " + $capacity + "%")}'
  fi
  exit
done

disconnected
