# frozen_string_literal: true

class ChangeColumnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:users, :admin, from: nil, to: "false")
  end
end
