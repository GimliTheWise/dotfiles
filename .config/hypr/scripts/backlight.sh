#!/bin/bash

# The script expects an argument
if [ "$#" -ne 1 ]; then
    echo "You need to provide an argument: +value or -value"
    exit 1
fi

# Define the file paths
CURRENT_BRIGHTNESS="/sys/class/backlight/intel_backlight/actual_brightness"
MAX_BRIGHTNESS="/sys/class/backlight/intel_backlight/max_brightness"
BRIGHTNESS="/sys/class/backlight/intel_backlight/brightness"

# Read current and maximum brightness values
read current_brightness < "$CURRENT_BRIGHTNESS"
read max_brightness < "$MAX_BRIGHTNESS"

# Get the provided argument value and the sign
value=${1:1}
sign=${1:0:1}

# Depending on the sign, increment or decrement the current brightness value
if [ "$sign" == "+" ]; then
    new_brightness=$((current_brightness + value))
elif [ "$sign" == "-" ]; then
    new_brightness=$((current_brightness - value))
else
    echo "only +/-[value] supported"
    exit 1
fi


# Adjust the new value if it is outside the acceptable range
if [ "$new_brightness" -lt 0 ]; then
    new_brightness=0
elif [ "$new_brightness" -gt "$max_brightness" ]; then
    new_brightness="$max_brightness"
fi

# Write the new value
echo "$new_brightness" > "$BRIGHTNESS"

echo "New brightness value set to: $new_brightness"
exit 0
