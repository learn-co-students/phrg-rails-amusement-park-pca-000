# frozen_string_literal: true

class Ride < ActiveRecord::Base
  belongs_to :attraction
  belongs_to :user

  def take_ride
    if tix_and_height_check
      "Sorry. You do not have enough tickets to ride the #{attraction.name}\
. You are not tall enough to ride the #{attraction.name}."
    elsif ticket_check
      "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    elsif height_check
      "Sorry. You are not tall enough to ride the #{attraction.name}."
    else
      rode_it
    end
  end

  def tix_and_height_check
    user.tickets < attraction.tickets && user.height < attraction.min_height
  end

  def ticket_check
    user.tickets < attraction.tickets
  end

  def height_check
    user.height < attraction.min_height
  end

  def rode_it
    user.tickets -= attraction.tickets
    user.nausea += attraction.nausea_rating
    user.happiness += attraction.happiness_rating
    user.save
  end
end
