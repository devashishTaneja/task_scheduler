class User < ApplicationRecord
	has_many :tasks, dependent: :destroy
	validates :firstname, presence: true
	validates :lastname, presence: true
	validates :email, presence: true,  format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false }
	validates :password, presence: true
	has_secure_password

	def name
		return firstname+' '+lastname
	end
end