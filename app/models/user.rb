# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :rides
  has_many :attractions, through: :rides

  def mood
    return unless nausea && happiness
    nausea > happiness ? "sad" : "happy"
  end
end
