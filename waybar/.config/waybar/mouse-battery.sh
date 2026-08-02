#!/usr/bin/env bash
set -euo pipefail

disconnected() {
  jq -cn --arg text $'\U000f037e' \
    '{text: $text, class: "disconnected", tooltip: "Mouse disconnected"}'
}

for battery in /sys/class/power_supply/hidpp_battery_*; do
  [[ -d $battery && -r $battery/capacity ]] || continue

  capacity="$(<"$battery/capacity")"
  [[ $capacity =~ ^[0-9]+$ ]] || continue

  status="$(<"$battery/status")"
  [[ $status != "Unknown" ]] || continue

  if (( capacity >= 95 )); then
    icon=$'\U000f0079'
  elif (( capacity >= 85 )); then
    icon=$'\U000f0082'
  elif (( capacity >= 75 )); then
    icon=$'\U000f0081'
  elif (( capacity >= 65 )); then
    icon=$'\U000f0080'
  elif (( capacity >= 55 )); then
    icon=$'\U000f007f'
  elif (( capacity >= 45 )); then
    icon=$'\U000f007e'
  elif (( capacity >= 35 )); then
    icon=$'\U000f007d'
  elif (( capacity >= 25 )); then
    icon=$'\U000f007c'
  elif (( capacity >= 15 )); then
    icon=$'\U000f007b'
  else
    icon=$'\U000f007a'
  fi

  model="$(<"$battery/model_name")"
  jq -cn --arg text "$icon" --arg model "$model" --arg capacity "$capacity" \
    '{text: $text, class: "connected", tooltip: ($model + " battery: " + $capacity + "%")}'
  exit
done

disconnected
