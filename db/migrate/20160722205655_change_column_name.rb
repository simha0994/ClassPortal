class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
  	rename_column :course_mappings, :userID, :user_id
  	rename_column :course_mappings, :courseID, :course_id
  end
end
