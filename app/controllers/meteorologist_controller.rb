require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    url = "http://maps.googleapis.com/maps/api/geocode/json?address="
    specific_JSON_url = @street_address.gsub(" ","+")

    raw_data = open(url+specific_JSON_url).read
    parsed_data = JSON.parse(raw_data)
    @lat= parsed_data["results"][0]["geometry"]["location"]["lat"]
    @lon = parsed_data["results"][0]["geometry"]["location"]["lng"]

    #url = "https://api.darksky.net/forecast/1e16425d996cccdb5a23d817dc45542b/#{@lat},#{@lng}"
    url = "https://api.darksky.net/forecast/1e16425d996cccdb5a23d817dc45542b/37.8267,-122.4233"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)

    current = parsed_data["currently"]



    @current_temperature = current["temperature"]

    @current_summary = current["summary"]

    @summary_of_next_sixty_minutes = parsed_data["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data["daily"]["summary"]
    

    render("meteorologist/street_to_weather.html.erb")
  end
end
