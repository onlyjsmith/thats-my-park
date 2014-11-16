class FarmsController < ApplicationController
  def new
    @farm = Farm.new
  end
end
