# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    session[:user_id]
  end
end
