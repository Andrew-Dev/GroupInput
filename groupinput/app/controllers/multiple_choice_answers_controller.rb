class MultipleChoiceAnswersController < ApplicationController

	before_action :require_login

	def create
		question = MultipleChoiceQuestion.find(params[:question])
		answer = MultipleChoiceAnswer.new
		answer.multiple_choice_question = question
		answer.answer = params[:answer]
		if question.audience.isBroadcasting(question)
			flash[:danger] = "You cannot modify this question while it is broadcasting."
			redirect_to(audience_multiple_choice_question_path(question.audience,question.id))
		else
			if answer.save
				redirect_to(audience_multiple_choice_question_path(question.audience,question.id))
			else
				errors = ""
				answer.errors.each do |e|
					errors = errors
				end
				flash[:danger] = answer.errors.full_messages.join("")
				redirect_to(audience_multiple_choice_question_path(question))
			end
		end
		
	end
	def destroy
		answer = MultipleChoiceAnswer.find(params[:id])
		question = answer.multiple_choice_question
		if question.audience.isBroadcasting(answer.multiple_choice_question)
			flash[:danger] = "You cannot modify this question while it is broadcasting."
			redirect_to(audience_multiple_choice_question_path(question.audience,question))
		else
			answer.destroy
			redirect_to(audience_multiple_choice_question_path(question.audience,question))
		end
	end

	def responsecount
		answer = MultipleChoiceAnswer.find(params[:id])
		if answer.multiple_choice_question.audience.user == current_user
			render :plain => answer.multiple_choice_responses.count
		else
			render :plain => "fail"
		end
	end
	
	private

		def require_login
			unless user_signed_in?
				redirect_to(new_user_session_path)
			end
		end
end
