# frozen_string_literal: true

class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.belongs_to :user, foriegn_key: true
      t.belongs_to :attraction, foriegn_key: true
    end
  end
end
