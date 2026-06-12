#!/bin/bash

# Fetch weather from wttr.in

LOCATION="25.57845,85.12700"
CACHE="$HOME/.cache/weather.json"
mkdir -p "$(dirname "$CACHE")"

RAW=$(curl -sf --max-time 10 "wttr.in/${LOCATION}?format=j1")

if [ -z "$RAW" ] || ! echo "$RAW" | jq -e '.current_condition[0]' > /dev/null 2>&1; then
    exit 1
fi

TEMP_C=$(echo "$RAW"      | jq -r '.current_condition[0].temp_C')
FEELS_C=$(echo "$RAW"     | jq -r '.current_condition[0].FeelsLikeC')
HUMIDITY=$(echo "$RAW"    | jq -r '.current_condition[0].humidity')
PRESSURE=$(echo "$RAW"    | jq -r '.current_condition[0].pressure')
VISIBILITY=$(echo "$RAW"  | jq -r '.current_condition[0].visibility')
WIND_KMPH=$(echo "$RAW"   | jq -r '.current_condition[0].windspeedKmph')
WIND_DEG=$(echo "$RAW"    | jq -r '.current_condition[0].winddirDegree')
CLOUD=$(echo "$RAW"       | jq -r '.current_condition[0].cloudcover')
DESCRIPTION=$(echo "$RAW" | jq -r '.current_condition[0].weatherDesc[0].value')

WIND_MS=$(echo "$WIND_KMPH" | awk '{printf "%.2f", $1 / 3.6}')
VIS_M=$(echo "$VISIBILITY"  | awk '{printf "%.0f", $1 * 1000}')

jq -n \
  --arg     name  "$LOCATION"  \
  --argjson temp  "$TEMP_C"    \
  --argjson feels "$FEELS_C"   \
  --argjson hum   "$HUMIDITY"  \
  --argjson pres  "$PRESSURE"  \
  --argjson vis   "$VIS_M"     \
  --argjson wspd  "$WIND_MS"   \
  --argjson wdeg  "$WIND_DEG"  \
  --argjson cloud "$CLOUD"     \
  --arg     desc  "$DESCRIPTION" \
  '{
    "weather": [ { "description": $desc } ],
    "main": {
      "temp":       $temp,
      "feels_like": $feels,
      "humidity":   $hum,
      "pressure":   $pres
    },
    "visibility": $vis,
    "wind":   { "speed": $wspd, "deg": $wdeg },
    "clouds": { "all": $cloud },
    "name":   $name
  }' > "$CACHE"

exit 0
