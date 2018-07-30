# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :rides
  has_many :attractions, through: :rides
  validates :password, presence: true

  def mood
    if nausea && happiness
      nausea > happiness ? "sad" : "happy"
    end
  end

  def user_name=(name)
    self.name = name
  end

  def user_name
    name
  end
end
