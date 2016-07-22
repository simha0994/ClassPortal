class Course < ApplicationRecord
	validates :number, :title, :description, :instructor, :startdate, :enddate, :status, presence: true
	
	has_many :course_mappings
	has_many :users, through: :course_mappings

end
