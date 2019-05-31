# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    return unless params[:ride_id]
    @ride = Ride.find_by_id(params[:ride_id])
    @user = @ride.user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if params[:user][:admin] == "1"
      @user.admin = true
      @user.save
    end
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

private

  def user_params
    params.require(:user).permit(:name, :height, :nausea, :happiness, :tickets, :password)
  end
end
