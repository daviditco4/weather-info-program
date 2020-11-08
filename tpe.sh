#!/bin/bash

if [ $# -ne 3 ]
then
	echo "You must provide arguments: 'latitude' 'longitude' 'quantity'"
	exit 1
fi

echo "Calling OpenWeatherMap API..."
curl -# "https://api.openweathermap.org/data/2.5/find?lat=$1&lon=$2&cnt=$3&mode=xml&appid=$OPENWEATHER_API" |
    java net.sf.saxon.Query -s:- -qs:/ '!indent=yes' > output/data.xml

echo "Extracting weather data..."
java net.sf.saxon.Query -s:files/countries.xml -q:files/extract_weather_data.xq '!indent=yes' > output/weather_data.xml

echo "Generating weather page..."
java net.sf.saxon.Transform -s:output/weather_data.xml -xsl:files/generate_page.xsl -o:output/weather_page.html

echo "Done."
exit 0
