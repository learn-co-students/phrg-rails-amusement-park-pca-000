class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
    t.integer :user_id
    t.integer :attraction_id
    t.datetime :created_at, null: false
    t.datetime :updated_at, null: false
    t.index [:attraction_id], name: "index_rides_on_attraction_id"
    t.index [:user_id], name: "index_rides_on_user_id"
    end
  end
end
