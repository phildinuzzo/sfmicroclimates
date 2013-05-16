Weather::Application.routes.draw do

  get "statusboard.json" => "weather#get_weather"

end
