# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @message = params[:message] if params[:message]
    @message ||= false

    if verify_login
      @user = User.find_by_id(params[:id])
      if params[:ride_id]
        @ride = Ride.find_by_id(params[:ride_id])
        @user = @ride.user
      end
    else
      redirect_to "/"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.admin = params[:user][:admin] == "1"
      @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_user_path
    end
  end

  def edit; end

private

  def user_params
    params.require(:user).permit(
      :name,
      :password,
      :height,
      :tickets,
      :happiness,
      :nausea,
      :admin
    )
    end
end
