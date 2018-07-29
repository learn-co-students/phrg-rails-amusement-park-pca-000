# frozen_string_literal: true

class AttractionsController < ApplicationController
  before_action :find_attraction, only: %i[update show edit]

  def index
    @user = current_user
    @attractions = Attraction.all
  end

  def show
    # binding.pry
    @user = current_user
    @attraction = Attraction.find_by(id: params[:id])
  end

  def new
    @attraction = Attraction.new
  end

  def edit; end

  def create
    attraction = Attraction.new(attraction_params)
    if attraction.save
      redirect_to attraction_path(attraction)
    else
      redirect_to new_attraction_path
    end
  end

  def ride
    ride = Ride.new
    ride.user = current_user
    ride.attraction = Attraction.find_by(id: params[:attraction_id])
    ride.save
    flash[:messages] = ride.take_ride
    redirect_to user_path(current_user)
  end

  def update
    @attraction.update(attraction_params)
    redirect_to attraction_path(@attraction)
  end

private

  def find_attraction
    @attraction = Attraction.find_by(params[:id])
  end

  def attraction_params
    params.require(:attraction).permit(:name,
                                       :tickets,
                                       :nausea_rating,
                                       :happiness_rating,
                                       :min_height)
  end
end
