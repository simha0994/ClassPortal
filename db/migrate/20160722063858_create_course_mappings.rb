class CreateCourseMappings < ActiveRecord::Migration[5.0]
  def change
    create_table :course_mappings do |t|
      t.integer :courseID
      t.integer :userID
      t.string :decision
      t.string :grade

      t.timestamps
    end
  end
end
