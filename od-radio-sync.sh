#!/bin/bash  
echo $#
if [ $# -lt 2 ]; then
    echo "Usage: $0 'Radio Hostname (ex 192.168.0.5)' 'Absolute Path to Stations File (ex: /home/patrick/documents/radio-stations.csv)'"
    exit 1
fi

: "Read the input parameters"
radio_url=$1
stations_file=$2

: " Read CSV data from the file to an array entitled stations.
In doing so, filter out the first (header) line any empty lines (',').
We intentionally want to read this first and store it temporarily so that
if there are any fatal errors while reading the file, we know before we
clear the radio's memory."
mapfile -t stations < <(csvcut $stations_file -c Title,URL | grep -v -w "," | tail -n +2)

: "Clear out the radio's station memory by deleting 100 stations: these radios
can only hold up to 100 stations."
for i in {1..100}
do
	curl "${radio_url}/cgi-bin/EN/cgi?CD=0;CI=0" > /dev/null
done

: "For each station that we read earlier"
for i in "${stations[@]}"
do
	: "Tokenize the station line into an array and then into variables for readability"
	IFS=',' read -r -a station_parts <<< $i
	title=${station_parts[0]}
	station_url=${station_parts[1]}

	: "POST the station data to the radio"
	curl -X POST "${radio_url}/cgi-bin/EN/cgi?CA=0;CI=0" -d "channel_name=${title}&channel_url=${station_url}" > /dev/null
done
