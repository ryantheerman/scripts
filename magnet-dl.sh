#!/bin/bash

MAGNET_URI="$1"
TIMESTAMP=$(date +%s)
OUTFILE="/mnt/nfs/torrent/magnets/magnet_$TIMESTAMP.magnet"

echo "$MAGNET_URI" > "$OUTFILE"

