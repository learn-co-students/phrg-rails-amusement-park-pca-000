# frozen_string_literal: true

require "pry"

class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    tall_enough, enough_tickets = check
    if tall_enough
      enough_tickets ? go : "Sorry. " + no_t
    else
      enough_tickets ? "Sorry. " + no_h : "Sorry. " + no_t + " " + no_h
    end
  end

  def check
    tall_enough = false
    enough_tickets = false
    tall_enough = true if user.height >= attraction.min_height
    enough_tickets = true if user.tickets >= attraction.tickets
    [tall_enough, enough_tickets]
  end

  def go
    nausea = user.nausea + attraction.nausea_rating
    happiness = user.happiness + attraction.happiness_rating
    user.update(tickets: new_tickets, nausea: nausea, happiness: happiness)
    successful_ride
  end

  def new_tickets
    user.tickets - attraction.tickets
  end

  def no_h
    "You are not tall enough to ride the #{attraction.name}."
  end

  def no_t
    "You do not have enough tickets to ride the #{attraction.name}."
  end

  def successful_ride
    "Thanks for riding the #{attraction.name}!"
  end
end
