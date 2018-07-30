# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :rides
  has_many :attractions, through: :rides

  def mood
    if nausea > happiness && nausea != happiness
      "sad"
    elsif nausea < happiness && nausea != happiness
      "happy"
    end
  end
end
