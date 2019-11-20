#!/bin/bash
# by Max-Joseph Krempl (krempl@in.tum.de)

DIR=$(dirname "$0")
getStreamURL="$DIR/_getStreamURL.sh"
OUTPUT_DIR="$DIR/saved"

error() {
	echo -e "$1"
	exit 1
}

[ ! -f "$getStreamURL" ] && error "Couldn't find \"$getStreamURL\""


if [ $# -ge 2 ]
then
	URL=$($getStreamURL "$1")
	ffmpeg -i "$URL" -c copy "${OUTPUT_DIR}/$2.mp4"
else
	error "Usage:  $(basename "$0") {live.rbg.tum.de url} {file name}"
fi
