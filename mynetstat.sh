#!/bin/sh
#
# Script: mynetstat.sh
# Description:
#   Show active TCP connections with address, CC, id, etc.
#   Optional argument: flowid — filters for matching flowid only
#
# Usage:
#   ./mynetstat.sh              # show all TCP connections
#   ./mynetstat.sh <flowid>     # show only matching flowid

FLOWID=$1

if [ -z "$FLOWID" ]; then
    # No flowid provided → show all TCP connections
    netstat -ncCRp tcp
else
    # Flowid provided → filter output
    echo ">>> Showing TCP connections with flowid: $FLOWID"
    # Use grep with word boundary to avoid partial matches
    netstat -ncCRp tcp | awk -v id="$FLOWID" '
        NR==1 || NR==2 { print; next }  # always print headers
        $6 ~ id { print }               # match flowid column (6th field)
    '
fi
