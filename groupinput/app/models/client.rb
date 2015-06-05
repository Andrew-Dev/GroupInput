class Client < ActiveRecord::Base
	has_and_belongs_to_many :audiences
	has_many :multiple_choice_responses

	def generateToken
		token = SecureRandom.base64(64)
		if self.class.exists?(token: token)
			generateToken
		else
			self.token = token
		end
	end
end
