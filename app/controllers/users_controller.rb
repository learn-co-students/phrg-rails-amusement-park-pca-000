# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  def show
    @message = params[:message] if params[:message]
    @message ||= false

    if session[:user_id]
      @user = User.find_by(id: params[:id])
      if params[:ride_id]
        @ride = Ride.find_by_id(params[:ride_id])
        @user = @ride.user
      end
    else
      redirect_to "/"
    end
  end

private

  def user_params
    params.require(:user).permit(
      :name,
      :height,
      :tickets,
      :happiness,
      :nausea,
      :password,
      :admin
    )
  end
end
