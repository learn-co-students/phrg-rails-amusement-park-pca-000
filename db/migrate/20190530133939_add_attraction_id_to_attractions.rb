# frozen_string_literal: true

class AddAttractionIdToAttractions < ActiveRecord::Migration[5.2]
  def change
    add_column :attractions, :attraction_id, :integer
  end
end
