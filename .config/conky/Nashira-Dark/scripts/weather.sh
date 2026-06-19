#!/bin/bash
 
LOCATION="Patna"
CACHE="$HOME/.cache/weather.json"
mkdir -p "$(dirname "$CACHE")"
 
RAW=$(curl -sf --max-time 10 "wttr.in/${LOCATION}?format=j1")
 
if [ -z "$RAW" ] || ! echo "$RAW" | jq -e '.current_condition[0]' > /dev/null 2>&1; then
    exit 1
fi
 
# Parse all fields in one jq call
PARSED=$(echo "$RAW" | jq -r '.current_condition[0] | "\(.temp_C)\t\(.FeelsLikeC)\t\(.humidity)\t\(.pressure)\t\(.visibility)\t\(.windspeedKmph)\t\(.winddirDegree)\t\(.cloudcover)\t\(.weatherCode)\t\(.weatherDesc[0].value)"')
 
TEMP_C=$(echo "$PARSED"      | cut -f1)
FEELS_C=$(echo "$PARSED"     | cut -f2)
HUMIDITY=$(echo "$PARSED"    | cut -f3)
PRESSURE=$(echo "$PARSED"    | cut -f4)
VISIBILITY=$(echo "$PARSED"  | cut -f5)
WIND_KMPH=$(echo "$PARSED"   | cut -f6)
WIND_DEG=$(echo "$PARSED"    | cut -f7)
CLOUD=$(echo "$PARSED"       | cut -f8)
WEATHER_CODE=$(echo "$PARSED"| cut -f9)
WTTR_DESC=$(echo "$PARSED"   | cut -f10)
 
case "$WEATHER_CODE" in
    113) DESC="Sunny" ;;
    116) DESC="Partly Cloudy" ;;
    119) DESC="Cloudy" ;;
    122) DESC="Overcast" ;;
    143) DESC="Haze" ;;
    176) DESC="Patchy Rain Nearby" ;;
    179) DESC="Patchy Snow Nearby" ;;
    182) DESC="Patchy Sleet Nearby" ;;
    185) DESC="Patchy Freezing Drizzle" ;;
    200) DESC="Thundery Outbreaks Nearby" ;;
    227) DESC="Blowing Snow" ;;
    230) DESC="Blizzard" ;;
    248) DESC="Foggy" ;;
    260) DESC="Rime Fog" ;;
    263) DESC="Light Drizzle" ;;
    266) DESC="Drizzle" ;;
    281) DESC="Light Freezing Drizzle" ;;
    284) DESC="Freezing Drizzle" ;;
    293) DESC="Light Rain" ;;
    296) DESC="Rain" ;;
    299) DESC="Heavy Rain at Times" ;;
    302) DESC="Heavy Rain" ;;
    305) DESC="Heavy Rain at Times" ;;
    308) DESC="Very Heavy Rain" ;;
    311) DESC="Light Freezing Rain" ;;
    314) DESC="Freezing Rain" ;;
    317) DESC="Light Sleet" ;;
    320) DESC="Moderate Sleet" ;;
    323) DESC="Patchy Light Snow" ;;
    326) DESC="Light Snow" ;;
    329) DESC="Patchy Moderate Snow" ;;
    332) DESC="Snow" ;;
    335) DESC="Patchy Heavy Snow" ;;
    338) DESC="Heavy Snow" ;;
    350) DESC="Ice Pellets" ;;
    353) DESC="Light Showers" ;;
    356) DESC="Showers" ;;
    359) DESC="Heavy Showers" ;;
    362) DESC="Light Sleet Showers" ;;
    365) DESC="Sleet Showers" ;;
    368) DESC="Light Snow Showers" ;;
    371) DESC="Snow Showers" ;;
    374) DESC="Light Ice Pellet Showers" ;;
    377) DESC="Ice Pellet Showers" ;;
    386) DESC="Thunderstorm With Light Rain" ;;
    389) DESC="Thunderstorm With Heavy Rain" ;;
    392) DESC="Thunderstorm With Light Snow" ;;
    395) DESC="Thunderstorm With Heavy Snow" ;;
      *) DESC="$WTTR_DESC" ;;
esac
 
jq -n \
    --arg     name  "$LOCATION"   \
    --arg     desc  "$DESC"       \
    --argjson temp  "$TEMP_C"     \
    --argjson feels "$FEELS_C"    \
    --argjson hum   "$HUMIDITY"   \
    --argjson pres  "$PRESSURE"   \
    --argjson vis   "$VISIBILITY" \
    --argjson wspd  "$WIND_KMPH"  \
    --argjson wdeg  "$WIND_DEG"   \
    --argjson cloud "$CLOUD"      \
    '{"weather":[{"description":$desc}],"main":{"temp":$temp,"feels_like":$feels,"humidity":$hum,"pressure":$pres},"visibility":($vis*1000),"wind":{"speed":(($wspd/3.6)*100|round/100),"deg":$wdeg},"clouds":{"all":$cloud},"name":$name}' \
    > "$CACHE"
