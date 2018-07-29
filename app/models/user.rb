# frozen_string_literal: true

class User < ApplicationRecord
  has_many :rides
  has_many :attractions, through: :rides
  has_secure_password

  def mood
    return unless nausea && happiness
    nausea > happiness ? "sad" : "happy"
  end

  def admin_status
    if admin
      "ADMIN"
    else
      ""
    end
  end
end
