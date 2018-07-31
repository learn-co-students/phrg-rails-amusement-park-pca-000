# frozen_string_literal: true

class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if not_enough_tickets? && not_tall_enough?
      tickets_denied + " " + height_denied
    elsif not_tall_enough?
      "Sorry. " + height_denied
    elsif not_enough_tickets?
      tickets_denied
    else
      ride_the_ride
      thank_you
    end
  end

private

  def tickets_denied
    "Sorry. You do not have enough tickets to ride the #{attraction.name}."
  end

  def height_denied
    "You are not tall enough to ride the #{attraction.name}."
  end

  def not_enough_tickets?
    true if user.tickets < attraction.tickets
  end

  def not_tall_enough?
    true if user.height < attraction.min_height
  end

  def ride_the_ride
    user.tickets -= attraction.tickets
    user.nausea += attraction.nausea_rating
    user.happiness += attraction.happiness_rating
    user.save
  end

  def thank_you
    "Thanks for riding the #{attraction.name}!"
  end
end
