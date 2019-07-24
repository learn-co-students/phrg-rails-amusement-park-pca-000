# frozen_string_literal: true

class User < ApplicationRecord
  has_many :rides
  has_many :attractions, through: :rides
  has_secure_password

  def mood
    return if admin == true
    nausea > happiness ? "sad" : "happy"
  end
end
