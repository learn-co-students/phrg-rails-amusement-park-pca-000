# frozen_string_literal: true

class AttractionsController < ApplicationController
  def index
    @attractions = Attraction.all
  end
end
