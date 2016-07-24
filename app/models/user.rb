class User < ApplicationRecord
	has_secure_password
	#attr_accessible :password, :password_confirmation

	#validates :password, presence: true, length: { minimum: 6 } if new?
	#validates :password_confirmation, presence: true if new?

end
