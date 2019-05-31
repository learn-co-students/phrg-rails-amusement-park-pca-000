# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if params[:user][:admin] == "1"
      user.admin = true
      user.save
    end
    session[:user_id] = user.id
    redirect_to user_path(user)
  end

  def show
    if !logged_in?
      redirect_to "/"
    else
      @user = User.find_by_id(params[:id])
      return unless params[:ride_id]
      @ride = Ride.find_by_id(params[:ride_id])
      @user = @ride.user
    end
  end

  def edit; end

private

  def user_params
    params.require(:user)
          .permit(
            :name,
            :height,
            :happiness,
            :nausea,
            :tickets,
            :password
          )
  end
end
