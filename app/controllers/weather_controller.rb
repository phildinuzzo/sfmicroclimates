class WeatherController < ApplicationController
  require 'open-uri'
  respond_to :json

  def get_weather

    stations = {
      "Nob Hill" => "KCASANFR152",
      "FiDi" => "KCASANFR102",
      "Mission" => "KCASANFR79",
      "SOMA" => "KCASANFR14",
      "Hayes Valley" => "KCASANFR49",
      "Potrero Hill" => "ME1927",
      "Richmond" => "KCASANFR97",
      "Twin Peaks" => "KCASANFR34",
      "Ocean Beach" => "KCASANFR107"
    }

    @export_array = []

    stations.size.times do |i|
      url = "http://api.wunderground.com/api/#{ENV['WU_KEY']}/conditions/q/pws:#{stations.values[i]}.json"
      open(url) do |f|
        json_string = f.read
        parsed_json = JSON.parse(json_string)
        @temp_f = parsed_json['current_observation']['temp_f']
      end
        @export_array << {"title" => "#{stations.keys[i]}", "value" => @temp_f}

    end

    @min = []
    @max = []
    @export_array.size.times do |i|
      @min << @export_array[i]["value"]
      @max << @export_array[i]["value"]
    end

    @m = @min.min - 5
    @m2 = @max.max + 5

    @output_hash = {"graph" =>
                    {
                      "title" => "San Francisco",
                      "yAxis" => {
                        "minValue" => @m,
                        "maxValue" => @m2,
                        "units" => {
                          "suffix" => " F"
                        }
                      },
                      "total" => false,
                      "datasequences" => [
                        {
                          "title" => "Microclimates",
                        "datapoints" => @export_array
                        }
                      ]
                     }
                    }

      render :json => @output_hash
  end


end

