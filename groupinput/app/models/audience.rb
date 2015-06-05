class Audience < ActiveRecord::Base
	belongs_to :user
	validates :title, presence: true, length: { maximum: 40 }
	has_many :textquestions
	has_many :multiple_choice_questions
	has_and_belongs_to_many :clients

	obfuscate_id :spin => 133742069

	def generateCode
		generatedCode = SecureRandom.hex(4)
		generatedCode = generatedCode.upcase
		if self.class.exists?(code: generatedCode)
			generateCode
		else
			self.code = generatedCode
		end
	end

	def isBroadcasting(question)
		if self.broadcast == nil
			return false
		else
			return JSON[self.broadcast]["id"] == question.id
		end
	end

	def verifyClient(client)
		self.clients.each do |c|
			if c == client
				return true
			end
		end
		return false
	end
end