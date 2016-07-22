class User < ApplicationRecord
  has_secure_password
  	validates :password, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true,length:{maximum:255},format: {with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
  validates :usertype,
    :inclusion  => { :in => [ 'Admin', 'Instructor', 'Student'],
    :message    => "%{value} is not a valid usertype" }

    has_many :course_mappings
	has_many :courses, through: :course_mappings
end
