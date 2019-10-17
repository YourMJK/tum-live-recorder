#!/bin/bash
# by Max-Joseph Krempl (krempl@in.tum.de)

DIR="$(dirname "$0")"
saveCurrentStream="$DIR/_saveCurrentStream.sh"


OUTPUT_DIR="$DIR/saved"  # Folder where recordings are saved to


error() {
	echo -e "$1"
	exit 1
}

date=$(which gdate)
[[ -z "$date" ]] && date="date"  # Use gdate if it's installed (required on macOS/BSD)

[ ! -d "$OUTPUT_DIR" ] && mkdir "$OUTPUT_DIR"  # Create output directory if it doesn't exist

[ ! -f "$saveCurrentStream" ] && error "Couldn't find script \"$saveCurrentStream\""


if [ $# -ge 1 ]
then
	[[ -n "$(which caffeinate)" ]] && caffeinate -imsw $$ &  # Prevents computer from sleeping while script is running, if caffeinate is installed (macOS/BSD)

	TARGET_TIME=$($date -d "$1" +%s) || exit 1
	echo "Recording starts on:  $($date -d "$1")"
	
	# countdown
	CURRENT_TIME=$(date +%s)
	while [[ $CURRENT_TIME -lt $TARGET_TIME ]]
	do
		DELTA_TIME=$((TARGET_TIME-CURRENT_TIME-1))
		COUNTDOWN="$($date -ud "@$DELTA_TIME" +%H:%M:%S)"
		[ $DELTA_TIME -ge 86400 ] && COUNTDOWN="$((DELTA_TIME/86400)) day(s) and $COUNTDOWN"
		echo -ne "\r$COUNTDOWN\033[0K"
		sleep 1
		CURRENT_TIME=$(date +%s)
	done
	echo -e "\n"
	
	# start recording
	if [ $# -ge 2 ]
	then $saveCurrentStream "$OUTPUT_DIR" "$2"
	else $saveCurrentStream "$OUTPUT_DIR"
	fi
else
	CMD="$(basename "$0")"
	echo "Usage:     $CMD {time/date} [file name]"
	echo ""
	echo "Examples:  $CMD now"
	echo "           $CMD 13:15"
	echo "           $CMD \"tomorrow 08:15\""
	echo "           $CMD \"wed 08:15\""
	echo ""
	echo "           $CMD 08:15 LA"
	exit 1
fi
