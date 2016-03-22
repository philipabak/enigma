class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :get_location, :get_time, :get_weather

  def get_location
    @current_location = request.location
  end

  def get_time
    tzc = TZInfo::Country.get(@current_location.data["country_code"]) rescue TZInfo::Country.get('GB')
    timezone = Timezone::Zone.new zone:tzc.zone_names.first
    @current_time = timezone.local_to_utc(Time.now)
  end

  def get_weather
    lat = @current_location.latitude
    lon = @current_location.longitude
    url = "http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&appid=#{Figaro.env.weather_appid}"
    @current_weather = Rails.cache.fetch "enigma.weather_#{lat}_#{lon}", expires_in: 30.minutes do
#      JSON.parse(RestClient.get(url))
    end
  end

end
