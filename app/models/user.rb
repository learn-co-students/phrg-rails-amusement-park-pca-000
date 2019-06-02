# frozen_string_literal: true

class User < ApplicationRecord
  has_many :rides
  has_many :attractions, through: :rides
  has_secure_password

  def mood
    return unless nausea && happiness
    if nausea > happiness
      "sad"
    else
      "happy"
    end
  end
end
