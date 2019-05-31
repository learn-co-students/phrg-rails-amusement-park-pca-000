# frozen_string_literal: true

class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(id: params[:user][:name])
    if user.try(:authenticate, params[:user][:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to "/signin"
    end
  end

  def destroy
    session.clear
    redirect_to root_url
  end
end
