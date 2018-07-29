# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  skip_before_action :require_login, only: %i[new home create]
  helper_method :current_user, :logged_in?, :require_login

  def require_login
    redirect_to "/" unless session.include? :user_id
  end

  def current_user
    @user = User.find_by(params[:id])
  end

  def logged_in?
    @user = current_user
  end
end
