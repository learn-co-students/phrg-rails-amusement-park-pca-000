# frozen_string_literal: true

class User < ApplicationRecord
  has_many :rides
  has_many :attractions, through: :rides
  has_secure_password

  def mood
    if happiness > nausea
      "happy"
    else
      "sad"
    end
  end
end
