API_ROUTE = 'http://onlyjsmith.cartodb.com/api/v2/sql'
API_KEY = '9a492f35d4a7bf7003ed82256bf9b38e39cb6eb6'

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
  end
end
