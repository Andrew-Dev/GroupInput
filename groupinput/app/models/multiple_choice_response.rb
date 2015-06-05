class MultipleChoiceResponse < ActiveRecord::Base
	belongs_to :multiple_choice_answer
	belongs_to :client
end
