#!/bin/sh

display_muted () {
    amixer sget Master | grep "Front.*:" | awk -F" " '{print $5 " (M)"}' | tail -n1 | sed -e 's/\[//' -e 's/\]//'
}

display_unmuted () {
    amixer sget Master | grep "Front.*:" | awk -F" " '{print $5}' | tail -n1 | sed -e 's/\[//' -e 's/\]//'
}

display_volume() {
    volume="$(amixer get Master | tail -1 | awk '{print $5}' | sed 's/[^0-9]*//g')"
    mute="$(amixer get Master | tail -1 | awk '{print $6}' | sed 's/[^a-z]*//g')"
    if [[ "$volume" == 0 || "$mute" == "off" ]]; then
	echo "Vol: <b>MM%</b>";
    else
	echo "Vol: <b>$volume%</b>";
    fi
}

increment_volume() {
    volume="$(amixer get Master | tail -1 | awk '{print $5}' | sed 's/[^0-9]*//g')"
    if [[ "$volume" -le 95 ]]; then
	amixer set Master 5%+ > /dev/null
    fi
}
decrement_volume() {
    volume="$(amixer get Master | tail -1 | awk '{print $5}' | sed 's/[^0-9]*//g')"
    if [[ "$volume" -ge 5 ]]; then
	amixer set Master 5%- > /dev/null
    fi
}

toggle_mute() {
    amixer set Master 1+ toggle;
}

case $1 in
    2) display_volume ;;
    1) increment_volume ;;
    0) decrement_volume ;;
    -1) toggle_mute ;;
esac
