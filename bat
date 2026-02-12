#!/bin/sh

BATN=BAT${1:-1}

[ -e "/sys/class/power_supply/${BATN}" ] || {
	printf 'Battery "%s" is not accesible via the sysfs interface.\n' "$BATN"
	exit 1
}

cd "/sys/class/power_supply/${BATN}"

cat <<EOF
status:      $(cat status)
capacity:    $(cat capacity)%
voltage:     $(( $(cat voltage_now) / 1000 ))kV
EOF

[ -e "/sys/class/power_supply/AC" ] && 
	[ "$(cat /sys/class/power_supply/AC/online)" = "1" ] && 
	echo "AC connected."
