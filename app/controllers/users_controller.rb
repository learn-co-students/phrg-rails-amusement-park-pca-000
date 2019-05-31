# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.admin = true if params[:user][:admin] == "1"
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    redirect_to "/" if @user.id != session[:user_id]
    @ride = Ride.find_by(id: params[:id])
  end

  def edit; end

private

  def user_params
    params.require(:user).permit(
      :name,
      :password,
      :password_confirmation,
      :happiness,
      :tickets,
      :height,
      :nausea,
      :admin
    )
  end
end
