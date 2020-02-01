#!/bin/bash

# Raspbian
vcgencmd measure_temp

# Ubuntu
#cat /sys/class/thermal/thermal_zone*/temp | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'
