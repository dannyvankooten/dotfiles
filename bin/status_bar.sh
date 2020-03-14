#!/bin/bash

VWRL=""

while true; do 
	if [[ "$VWRL" == "" ]] || [[ "$(date +'%M')" == "00" ]]; then
		VWRL=`vwrlwatch | awk 'NR==1 || NR==4' ORS=' | '`
	fi;

	OUTPUT="$VWRL"
	OUTPUT+=$(date +'%Y-%m-%d %l:%M:%S %p');
	echo "$OUTPUT";
	sleep 1; 
done
