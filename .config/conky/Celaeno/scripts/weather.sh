#!/bin/bash

# Variables
city_id=1260086 # get your city id at https://openweathermap.org/find and replace
api_key=46d1a7a336e50ffdfc64687ff7381b93 # Enter your api key
unit=metric # choose between metric(for Celcius) or imperial(for fahrenheit)
lang=en
url="api.openweathermap.org/data/2.5/weather?id=${city_id}&appid=${api_key}&cnt=5&units=${unit}&lang=${lang}"
curl ${url} -s -o ~/.cache/weather.json

exit
