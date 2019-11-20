#!/bin/bash
# by Max-Joseph Krempl (krempl@in.tum.de)

DIR=$(dirname "$0")
getStreamURL="$DIR/_getStreamURL.sh"
OUTPUT_DIR="$DIR/saved"

if [ $# -ge 2 ]
then
	URL=$($DIR/_getStreamURL.sh "$1")
	ffmpeg -i "$URL" -c copy "${OUTPUT_DIR}/$2.mp4"
else
	echo "Usage:  $(basename "$0") {live.rbg.tum.de url} {file name}"
	exit 1
fi
