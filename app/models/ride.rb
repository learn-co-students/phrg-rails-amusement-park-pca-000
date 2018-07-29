# frozen_string_literal: true

class Ride < ApplicationRecord
  belongs_to :attraction
  belongs_to :user

  def take_ride
    if not_enough_tickets? && not_tall_enough?
      (long_string_part_one + " " + long_string_part_two).to_s
    elsif not_enough_tickets?
      "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    elsif not_tall_enough?
      "Sorry. You are not tall enough to ride the #{attraction.name}."
    else
      riding
    end
  end

private

  def long_string_part_one
    "Sorry. You do not have enough tickets to ride the #{attraction.name}."
  end

  def long_string_part_two
    "You are not tall enough to ride the #{attraction.name}."
  end

  def riding
    user.update(
      tickets: user_tickets,
      nausea: user_nausea,
      happiness: user_happiness
    )
    "Thanks for riding the #{attraction.name}!"
  end

  def user_nausea
    user.nausea = attraction.nausea_rating + user.nausea
  end

  def user_tickets
    user.tickets = user.tickets - attraction.tickets
  end

  def user_happiness
    user.happiness = user.happiness + attraction.happiness_rating
  end

  def not_enough_tickets?
    user.tickets < attraction.tickets
  end

  def not_tall_enough?
    user.height < attraction.min_height
  end
end
