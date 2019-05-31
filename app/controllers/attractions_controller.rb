# frozen_string_literal: true

class AttractionsController < ApplicationController
  def index
    @attractions = Attraction.all
    @user = User.find_by_id(logged_in?)
  end

  def new
    @attraction = Attraction.new
  end

  def create
    attraction = Attraction.create(attraction_params)
    redirect_to attraction_path(attraction)
  end

  def show
    @attraction = Attraction.find_by_id(params[:id])
    @user = User.find_by_id(logged_in?)
    @ride = Ride.create(user_id: @user.id, attraction_id: @attraction.id)
  end

  def edit
    @attraction = Attraction.find_by_id(params[:id])
  end

  def update
    @attraction = Attraction.find_by_id(params[:id])
    @attraction.update(name: params[:attraction][:name])
    redirect_to attraction_path(@attraction)
  end

private

  def attraction_params
    params.require(:attraction)
          .permit(
            :name,
            :min_height,
            :happiness_rating,
            :nausea_rating,
            :tickets
          )
  end
end
