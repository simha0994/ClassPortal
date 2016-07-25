class CreateMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :materials do |t|
      t.integer :course_id
      t.text :information

      t.timestamps
    end
  end
end
