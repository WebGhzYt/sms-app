class Client < ActiveRecord::Base
	
	validates :name,:phone, presence: true
	validates :email, presence: true
	# , uniqueness: true
end
