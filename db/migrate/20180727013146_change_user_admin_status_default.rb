# frozen_string_literal: true

class ChangeUserAdminStatusDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :admin, :boolean, default: false
  end
end
