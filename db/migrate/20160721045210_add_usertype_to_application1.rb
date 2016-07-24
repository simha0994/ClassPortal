class AddUsertypeToApplication1 < ActiveRecord::Migration[5.0]
  def change
    add_column :application1s, :usertype, :string
  end
end
