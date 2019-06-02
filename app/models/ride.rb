# frozen_string_literal: true

class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if double_error?
      double_error
    elsif tickets_error?
      tickets_error
    elsif height_error?
      height_error
    else
      ride_update
    end
  end

  def height_error?
    attraction.min_height > user.height
  end

  def tickets_error?
    attraction.tickets > user.tickets
  end

  def double_error?
    attraction.tickets > user.tickets && attraction.min_height > user.height
  end

  def double_error
    "Sorry. You do not have enough tickets to ride the #{attraction.name}."\
    " You are not tall enough to ride the #{attraction.name}."
  end

  def tickets_error
    "Sorry. You do not have enough tickets to ride the #{attraction.name}."
  end

  def height_error
    "Sorry. You are not tall enough to ride the #{attraction.name}."
  end

  def ride_update
    user.tickets -= attraction.tickets
    user_happiness_nausea
    user.save
    goodbye
  end

  def user_happiness_nausea
    user.nausea += attraction.nausea_rating
    user.happiness += attraction.happiness_rating
  end

  def goodbye
    "Thanks for riding the #{attraction.name}!"
  end
end
