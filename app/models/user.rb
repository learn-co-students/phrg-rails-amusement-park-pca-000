class User < ApplicationRecord
  has_many :rides
  has_many :attractions, through: :rides
  has_secure_password

  def mood
    if happiness && nausea
      nausea > happiness ? "sad" : "happy"
    end
  end

  def admin_status
    if self.admin
      "ADMIN"
    else
      ""
    end
  end
end
