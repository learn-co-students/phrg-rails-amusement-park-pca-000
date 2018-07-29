# frozen_string_literal: true

class SessionController < ApplicationController
  def new
    @user = current_user
  end

  def create
    user = User.find_by(id: params[:user][:name])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to new_user_path(user)
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end
end
