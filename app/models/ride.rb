# frozen_string_literal: true

class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if too_poor
      too_poor_prompt
    elsif too_short
      too_short_prompt
    elsif too_poor_and_too_short
      too_poor_and_too_short_prompt
    else
      good_to_go
      good_to_go_prompt
    end
  end

private

  def too_poor
    user.tickets < attraction.tickets && user.height > attraction.min_height
  end

  def too_poor_prompt
    "Sorry. You do not have enough tickets to ride the #{attraction.name}."
  end

  def too_short
    user.tickets > attraction.tickets && user.height < attraction.min_height
  end

  def too_short_prompt
    "Sorry. You are not tall enough to ride the #{attraction.name}."
  end

  def too_poor_and_too_short
    user.tickets < attraction.tickets && user.height < attraction.min_height
  end

  def too_poor_and_too_short_prompt
    "Sorry. You do not have enough tickets to ride the " \
    "#{attraction.name}. You are not tall enough to ride " \
    "the #{attraction.name}."
  end

  def good_to_go
    user.tickets -= attraction.tickets
    user.nausea += attraction.nausea_rating
    user.happiness += attraction.happiness_rating
    user.save
  end

  def good_to_go_prompt
    "Thanks for riding the #{attraction.name}!"
  end
end
