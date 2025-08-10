#!/bin/bash

SWIPE_DIR="$1"
[[ "$SWIPE_DIR" != "left" && "$SWIPE_DIR" != "right" ]] && exit 1

# Get list of outputs in use by i3
mapfile -t active_outputs < <(
  i3-msg -t get_workspaces |
  jq -r '.[].output' | sort -u
)

# Get focused workspace and output
read -r current_ws current_output <<< $(i3-msg -t get_workspaces |
  jq -r '.[] | select(.focused) | "\(.name) \(.output)"')

# If only one output is in use, allow wraparound swiping from workspace 1
if [[ "${#active_outputs[@]}" -eq 1 ]]; then
  mapfile -t active_ws < <(
    i3-msg -t get_workspaces |
    jq -r --arg out "$current_output" '.[] | select(.output == $out) | .name' |
    grep -E '^[0-9]+$' | sort -n
  )

  idx=-1
  for i in "${!active_ws[@]}"; do
    [[ "${active_ws[i]}" == "$current_ws" ]] && idx=$i && break
  done

  [[ "$idx" -eq -1 ]] && exit 0

  if [[ "$SWIPE_DIR" == "left" ]]; then
    next_idx=$(( (idx + 1) % ${#active_ws[@]} ))
  else
    next_idx=$(( (idx - 1 + ${#active_ws[@]}) % ${#active_ws[@]} ))
  fi

  i3-msg workspace "${active_ws[$next_idx]}"
  exit 0
fi

# === Multi-output mode ===
# Never swipe from workspace 1 in this mode
[[ "$current_ws" == "1" ]] && exit 0

# Determine left/right output by x-offset from xrandr
readarray -t positions < <(
  xrandr --query |
  grep ' connected' |
  sed -nE 's/^([^\s]+) connected [0-9]+x[0-9]+\+([0-9]+)\+[0-9]+.*$/\1 \2/p' |
  sort -nk2
)

left_output=$(echo "${positions[0]}" | awk '{print $1}')
right_output=$(echo "${positions[-1]}" | awk '{print $1}')
center_output=""
for pos in "${positions[@]}"; do
  name=$(echo "$pos" | awk '{print $1}')
  if [[ "$name" != "$left_output" && "$name" != "$right_output" ]]; then
    center_output="$name"
    break
  fi
done

# Get visible workspaces on current output
mapfile -t visible_ws < <(
  i3-msg -t get_workspaces |
  jq -r --arg out "$current_output" '.[] | select(.output == $out) | .name' |
  grep -E '^[0-9]+$' | sort -n
)

# Apply monitor-specific filtering
if [[ "$current_output" == "$left_output" ]]; then
  mapfile -t filtered < <(printf "%s\n" "${visible_ws[@]}" | awk '$1 % 2 == 0')
elif [[ "$current_output" == "$right_output" ]]; then
  mapfile -t filtered < <(printf "%s\n" "${visible_ws[@]}" | awk '$1 % 2 == 1')
else
  exit 0
fi

[[ ${#filtered[@]} -eq 0 ]] && exit 0

idx=-1
for i in "${!filtered[@]}"; do
  [[ "${filtered[i]}" == "$current_ws" ]] && idx=$i && break
done

[[ "$idx" -eq -1 ]] && exit 0

if [[ "$SWIPE_DIR" == "left" ]]; then
  next_idx=$(( (idx + 1) % ${#filtered[@]} ))
else
  next_idx=$(( (idx - 1 + ${#filtered[@]}) % ${#filtered[@]} ))
fi

i3-msg workspace "${filtered[$next_idx]}"

