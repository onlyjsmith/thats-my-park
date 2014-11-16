API_ROUTE = 'http://onlyjsmith.cartodb.com/api/v2/sql'
API_KEY = Rails.application.secrets.cartodb_api_key
if API_KEY == 'api-key-here'
  raise "No cartodb_api_key key specified in secrets.yml (see secrets.yml.example)"
end

# FarmsController == ClaimsController == we'll throw away
class FarmsController < ApplicationController
  def new
    @farm = Farm.new
  end

  def start
    @farm = Farm.new
  end

  def track
  end

  def submit
  end

  def submitted
  end

  def create
    query = params[:query]
    puts "Sending query #{API_ROUTE}?q=#{query}&api_key=#{API_KEY}"
    RestClient.get API_ROUTE, params: { q: query, api_key: API_KEY }

    render json: {message: 'OK'}
  end
end
