# frozen_string_literal: true

class UsersController < ApplicationController
  def index; end

  def new
    @user = User.new
  end

  def create
    # binding.pry
    user = User.create(name: params[:user][:name], height: params[:user][:height], happiness: params[:user][:happiness], nausea: params[:user][:nausea], tickets: params[:user][:tickets], password: params[:user][:password])
    if params[:user][:admin] == "1"
      user.admin = true
      user.save
    end
    session[:user_id] = user.id
    redirect_to user_path(user)
  end

  def show
    @user = User.find_by_id(params[:id])
    return unless params[:ride_id]
    @ride = Ride.find_by_id(params[:ride_id])
    @user = @ride.user
  end

  def edit; end
end
