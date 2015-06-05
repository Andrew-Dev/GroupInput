class MultipleChoiceAnswer < ActiveRecord::Base
	belongs_to :multiple_choice_question
	has_many :multiple_choice_responses

end
