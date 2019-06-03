# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  skip_before_action :require_login, only: %i[new home create]

  include SessionsHelper

  def require_login
    redirect_to "/" unless session.include? :user_id
  end
end
