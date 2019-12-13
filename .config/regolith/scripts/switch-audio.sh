#!/bin/bash
# Arg 1: Set to wifi to use AirPlay, otherwise use local output

# Also to to do the following:
# $ cp /etc/pulse/default.pa ~/.config/pulse/
# and replace the line:
#   load-module module-stream-restore
# with:
#   load-module module-stream-restore restore_device=false
# Then run:
# $ pulseaudio -k

sink='alsa_output.pci-0000_00_1f.3.analog-stereo'
if [[ $1 == "wifi" ]]; then
    sink='raop_output.Hifi.local'
fi

pacmd set-default-sink $sink
for app in $(pacmd list-sink-inputs | sed -n -e 's/index:[[:space:]]\([[:digit:]]\)/\1/p'); do
  echo $app
  pacmd move-sink-input $app $sink
done
