#!/bin/bash

VWRL=""

while true; do 
	if [[ "$VWRL" == "" ]] || [[ "$(date +'%M')" == "00" ]]; then
		VWRL="$(vwrlwatch | head -n1) | "
	fi;

	OUTPUT="$VWRL "
	OUTPUT+=$(date +'%Y-%m-%d %l:%M:%S %p');
	printf "$OUTPUT\n";
	sleep 1; 
done
