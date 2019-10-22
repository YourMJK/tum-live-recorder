#!/bin/bash
# by Max-Joseph Krempl (krempl@in.tum.de)

EXT="m3u8"

if [ $# -ge 1 ]
then
	curl -s "$1" | grep ".$EXT" | head -n1 | sed "s|.*https|https|g" | sed "s|\.${EXT}.*|\.${EXT}|g"
else
	echo "Usage:  $(basename "$0") {live.rbg.tum.de url}"
	exit 1
fi
