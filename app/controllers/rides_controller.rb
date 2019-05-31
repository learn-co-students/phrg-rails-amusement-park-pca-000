# frozen_string_literal: true

class RidesController < ApplicationController
  def create; end

  def update
    @ride = Ride.find_by(id: params[:id])
    @user = User.find_by(id: @ride.user_id)
    redirect_to "/" if @user.id != session[:user_id]
    message = @ride.take_ride
    redirect_to user_path(@user), flash: { notice: message }
  end
end
