p "Where are you located?"

# user_location = gets.chomp

user_location = "Chicago"

p user_location

gmaps_api_endpoint = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=AIzaSyB92cYxPcYqgjwBJfWlwDQw_7yjuyU3tpA"

require "open-uri"

raw_response = URI.open(gmaps_api_endpoint).read

require "json"

parsed_response = JSON.parse(raw_response)

results_array = parsed_response.fetch("results")

first_result = results_array.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

pirate_api_endpoint = "https://api.pirateweather.net/forecast/3RrQrvLmiUayQ84JSxL8D2aXw99yRKlx1N4qFDUE/#{latitude},#{longitude}"

raw_response_pirate = URI.open(pirate_api_endpoint).read

parsed_response_pirate = JSON.parse(raw_response_pirate)

weather_array = parsed_response_pirate.fetch("hourly")

data_array = weather_array.fetch("data")

p hourly_array = data_array.fetch("temperature")
