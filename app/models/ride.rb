# frozen_string_literal: true

class Ride < ActiveRecord::Base
  belongs_to :attraction
  belongs_to :user

  def take_ride
    user = User.find_by(id: user_id)
    attraction = Attraction.find_by(id: attraction_id)
    if user.tickets < attraction.tickets && user.height > attraction.min_height
      "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    elsif user.tickets > attraction.tickets && user.height < attraction.min_height
      "Sorry. You are not tall enough to ride the #{attraction.name}."
    elsif user.tickets < attraction.tickets && user.height < attraction.min_height
      "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
    else
      user.tickets -= attraction.tickets
      user.nausea += attraction.nausea_rating
      user.happiness += attraction.happiness_rating
      user.save
      "Thanks for riding the #{attraction.name}!"
    end
  end
end
