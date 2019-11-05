#!/bin/bash
# by Max-Joseph Krempl (krempl@in.tum.de)


URL_REGEX="https://live\.rbg\.tum\.de/cgi-bin/streams/MW.001.*/COMB"  # MW0001/MW2001 - Präsentation & Kamera
TIMEOUT="03:00:00"  # Maximum recording length


DIR="$(dirname "$0")"
getStreamURL="$DIR/_getStreamURL.sh"

error() {
	echo -e "$1"
	exit 1
}

[ ! -f "$getStreamURL" ] && error "Couldn't find \"$getStreamURL\""


if [ $# -ge 1 ]
then
	# extract stream url
	URL=$(curl -s "https://live.rbg.tum.de/cgi-bin/streams" | grep "$URL_REGEX" | head -n1 | sed "s|.*https|https|g" | sed "s|\".*||g") && \
	STREAM_URL=$($getStreamURL "$URL")
	[[ "$STREAM_URL" = "" ]] && error "No stream url found. ($URL_REGEX)\nStream currently not live?"
	[[ ! "$STREAM_URL" =~ https.*\.m3u8 ]] && error "Invalid stream url \"$STREAM_URL\""
	
	# determine output file (avoid overwrite)
	if [ $# -ge 2 ]
	then NAME="$2"
	else NAME="$(date +%Y-%m-%d)"
	fi
	FILE="$1/$NAME.mp4"
	i=2
	while [ -f "$FILE" ]
	do
		FILE="$1/${NAME}_$i.mp4"
		((i+=1))
	done
	
	# save stream to output file
	FFMPEG_INPUT="$DIR/.ffmpeg_input" ; echo "" > "$FFMPEG_INPUT"
	<$FFMPEG_INPUT ffmpeg -hide_banner -loglevel info -stats -i "$STREAM_URL" -t $TIMEOUT -c copy -n "$FILE" & #-progress "$FFMPEG_OUTPUT"
	FFMPEG_PID=$!
	echo "-" > "$FFMPEG_INPUT"  # decrease ffmpeg's loglevel verbosity to "warning" (after info was printed)
	
	sleep 2
	echo -e "\n\033[0;31m⬤\033[1m Recording\033[0m '$URL' stream to '$FILE'... ($(date +%H:%M:%S))\n(CRL-C to stop recording)\n"
	
	interrupt_handler() {
		[[ $INTERRUPTED -eq 1 ]] && return 0
		INTERRUPTED=1
		echo -e "\n\n\033[1m◼︎ Stopping recording...\033[0m ($(date +%H:%M:%S))"
		#kill -INT $FFMPEG_PID
		echo "q" > "$FFMPEG_INPUT"  # tell ffmpeg to quit
		wait $FFMPEG_PID
		rm "$FFMPEG_INPUT"
	}
	INTERRUPTED=0
	trap interrupt_handler SIGINT && wait $FFMPEG_PID
	
	interrupt_handler  # if ffmpeg quits naturally, also use interrupt_handler to perform cleanup
else
	error "Usage:  $(basename "$0") {output folder} [file name]"
fi
