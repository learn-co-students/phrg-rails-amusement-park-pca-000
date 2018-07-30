# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :verify_login
  skip_before_action :verify_login, only: %i[new home create]

  def verify_login
    true if session[:user_id]
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end
