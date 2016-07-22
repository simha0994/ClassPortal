class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :number
      t.string :title
      t.text :description
      t.string :instructor
      t.string :status
      t.date :startdate
      t.date :enddate

      t.timestamps
    end
  end
end
