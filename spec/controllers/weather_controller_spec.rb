require 'spec_helper'

describe WeatherController do

  describe "get_weather" do

    it "responds successfully with an HTTP 200 status code" do
      get :get_weather
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it "returns a JSON object" do
      get :get_weather
      response.header['Content-Type'].should include 'application/json'
    end

    it "should had API data in the output" do
      get :get_weather
      parsed = JSON.parse(response.body)
      expect(parsed['graph']['datasequences'][0]['datapoints'][0]['value']).to be_a_kind_of Float
    end

  end

end