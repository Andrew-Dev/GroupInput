class MultipleChoiceQuestion < ActiveRecord::Base
	belongs_to :audience
	validates :question, presence: true, length: { maximum: 140 }
	#obfuscate_id :spin => 4203133769
	has_many :multiple_choice_answers

	def checkDuplicateResponses(client)
		self.multiple_choice_answers.each do |answer|
			answer.multiple_choice_responses.each do |response|
				if response.client == client
					return true
				end
			end
		end
			return false
	end

	public

	  def as_json(options={})
	    super(include: [:multiple_choice_answers])
	  end
end
