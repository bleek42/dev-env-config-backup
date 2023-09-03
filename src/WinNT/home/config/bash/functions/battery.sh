#!/usr/bin/env bash

# ═══════════════════════════════════════
# BATTERY DIAGNOSTICS FOR PS1
# ═══════════════════════════════════════
# Check if the expected battery files exist
function bat_c() {
	[[ -f /sys/class/power_supply/BAT0/charge_full_design ]] &&
		[[ -f /sys/class/power_supply/BAT0/charge_now ]] &&
		[[ -f /sys/class/power_supply/BAT0/current_now ]] &&
		[[ -f /sys/class/power_supply/BAT0/status ]]
}
# Get current battery percentage, color it red if < 15%
function bat_p() {
	f=$(\cat /sys/class/power_supply/BAT0/charge_full_design 2>/dev/null)
	c=$(\cat /sys/class/power_supply/BAT0/charge_now 2>/dev/null)
	echo "$(bc -l <<<"$c/$f * 100")" | cut -c1-5
	#echo 10
}

# Get projected battery life time remaining
function bat_t() {
	c="$(\cat /sys/class/power_supply/BAT0/charge_now 2>/dev/null)"
	i="$(\cat /sys/class/power_supply/BAT0/current_now 2>/dev/null)"
	s="$(\cat /sys/class/power_supply/BAT0/status)"
	if [[ "$s" == "Full" ]]; then
		echo '🔌'
	else
		"$(bc -l <<<"$c/$i")" | cut -c1-5
	fi
}

# Get the current battery status: discharging, charging, or full
function bat_s() {
	s="$(\cat /sys/class/power_supply/BAT0/status)"
	if [[ "$s" == "Discharging" ]]; then
		echo -e "${ECHOR2}▾"
	elif [[ "$s" == "Charging" ]]; then
		echo -e "${ECHOG}▴"
	elif [[ "$s" == "Full" ]]; then
		echo -e "${ECHOG}▫"
	fi
}
