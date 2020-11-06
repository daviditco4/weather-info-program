#!/bin/bash

if [ $# -ne 3 ]
then
	echo "You must provide arguments: 'latitude' 'longitude' 'quantity'"
	exit 1
fi

echo "Calling OpenWeatherMap API..."
appid="3dd5b30af1424f8d32277d2734d6af89"
curl "https://api.openweathermap.org/data/2.5/find?lat=$1&lon=$2&cnt=$3&mode=xml&appid=$appid" -o output/data.xml
echo ""

echo "Extracting weather data..."
java net.sf.saxon.Query -s:files/countries.xml -q:files/extract_weather_data.xq > output/weather_data.xml

exit 0
