class AddUsertypeToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :usertype, :string
  end
end
