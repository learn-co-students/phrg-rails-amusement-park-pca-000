# frozen_string_literal: true

class Ride < ActiveRecord::Base
  belongs_to :user
  belongs_to :attraction

  def take_ride
    @user = self.user
    @attraction = self.attraction
    if !!requirements
      ride
    else
      requirement_problem
    end
  end

  def ride
    new_happiness = @user.happiness + @attraction.happiness_rating
    new_nausea = @user.nausea + @attraction.nausea_rating
    new_tickets =  @user.tickets - @attraction.tickets
    @user.update(
      :happiness => new_happiness,
      :nausea => new_nausea,
      :tickets => new_tickets
    )
    "Thanks for riding the #{@attraction.name}!"
  end


  def requirements
    @user.height >= @attraction.min_height && @user.tickets >= @attraction.tickets
  end

  def requirement_problem
    if @user.height < @attraction.min_height && @user.tickets < @attraction.tickets
      sorry + not_enough_tickets + " " + not_tall_enough
    elsif @user.height < @attraction.min_height
      sorry + not_tall_enough
    elsif @user.tickets < @attraction.tickets
      sorry + not_enough_tickets
    end
  end

  def sorry
    "Sorry. "
  end

  def not_enough_tickets
    "You do not have enough tickets to ride the " + attraction.name + "."
  end

  def not_tall_enough
    "You are not tall enough to ride the " + attraction.name + "."
  end

end
