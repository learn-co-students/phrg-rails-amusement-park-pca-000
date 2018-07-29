class Ride < ApplicationRecord
  belongs_to :attraction
  belongs_to :user

  def take_ride
    if not_enough_tickets? && not_tall_enough?
      "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
    elsif not_enough_tickets?
      "Sorry. You do not have enough tickets to ride the #{attraction.name}."
    elsif not_tall_enough?
      "Sorry. You are not tall enough to ride the #{attraction.name}."
    else
      riding
      "Thanks for riding the #{attraction.name}!"
    end
  end

  def riding
    user_nausea = attraction.nausea_rating + user.nausea
    user_tickets = user.tickets - attraction.tickets
    user_happiness = user.happiness + attraction.happiness_rating
    self.user.update(
    tickets: user_tickets,
    nausea: user_nausea,
    happiness: user_happiness
    )
  end

  def not_enough_tickets?
    user.tickets < attraction.tickets
  end

  def not_tall_enough?
    user.height < attraction.min_height
  end
end
