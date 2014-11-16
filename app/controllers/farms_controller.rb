API_ROUTE = '<api-route-here>' 
API_KEY = '<api-key-here>' 

class FarmsController < ApplicationController
  def new
    @farm = Farm.new
  end

  def create
    query = params[:query]
    puts "Sending query #{API_ROUTE}?q=#{query}&api_key=#{API_KEY}"
    RestClient.get API_ROUTE, {params: {q: query, api_key: API_KEY}}
  end
end
