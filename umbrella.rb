p "Will you need an umbrella today?"
p "Where are you located?"

# user_location = gets.chomp

user_location = "Chicago"

gmaps_token = ENV.fetch("GMAPS_KEY")
pirate_token = ENV.fetch("PIRATE_WEATHER_KEY")

p user_location

gmaps_api_endpoint = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_token}"

require "open-uri"
require "date"

raw_response = URI.open(gmaps_api_endpoint).read

require "json"

parsed_response = JSON.parse(raw_response)

results_array = parsed_response.fetch("results")

first_result = results_array.at(0)

geo = first_result.fetch("geometry")

loc = geo.fetch("location")

latitude = loc.fetch("lat")
longitude = loc.fetch("lng")

pirate_api_endpoint = "https://api.pirateweather.net/forecast/#{pirate_token}/#{latitude},#{longitude}"

raw_response_pirate = URI.open(pirate_api_endpoint).read

parsed_response_pirate = JSON.parse(raw_response_pirate)

weather_array = parsed_response_pirate.fetch("currently")

temp_array = weather_array.fetch("temperature")

p "It is currently " + temp_array.to_s + " degrees"

weather_array2 = parsed_response_pirate.fetch("hourly")

hourly_array = weather_array2.fetch("data")

#12.times do |hours|
 # at_temp_array = hourly_array.at(hours)
  #hourly_temp_array = at_temp_array.fetch("temperature")
  #p hourly_temp_array
#end

12.times do |hours|
  at_temp_array = hourly_array.at(hours)
  hourly_temp_array = at_temp_array.fetch("precipProbability")
  hourly_temp_array_percent = hourly_temp_array * 100
  if hourly_temp_array_percent > 10
    p "in " + hours.to_s + " hours there is a " + hourly_temp_array_percent.to_s + "% chance of rain"
  end
end
