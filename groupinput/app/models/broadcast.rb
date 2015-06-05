class Broadcast < ActiveRecord::Base
	has_one :textquestion
	has_one :multiple_choice_question
	
end
