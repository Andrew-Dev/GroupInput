class MultipleChoiceQuestionsController < ApplicationController

	before_action :require_login

	def index
		@audience = Audience.find(params[:audience_id])
		redirect_to(audience_path(@audience))
	end

	def new
		@audience = Audience.find(params[:audience_id])
		@answer = MultipleChoiceAnswer.new
		@question = MultipleChoiceQuestion.new
	end

	def create
		question = MultipleChoiceQuestion.new
		question.question = params[:multiple_choice_question][:question]
		question.audience = Audience.find(params[:audience_id])
		audience = Audience.find(params[:audience_id])
		if question.save
			redirect_to(audience_multiple_choice_question_path(audience,question))
		else
			errors = ""
			question.errors.each do |e|
				errors = errors
			end
			flash[:danger] = question.errors.full_messages.join("")			
			redirect_to(new_audience_multiple_choice_question_path(audience))
		end
	end

	def show
		audience = Audience.find(params[:audience_id])
		if audience.user == current_user
			@audience = audience
			@question = MultipleChoiceQuestion.find(params[:id])
			@questionjson = @question.to_json
		else
			redirect_to('/')
		end
	end

	def destroy
		question = MultipleChoiceQuestion.find(params[:id])
<<<<<<< HEAD
		audience = question.audience
=======
		audience = @question.audience
>>>>>>> parent of 5e0aecd... Finished beta of app with working textquestions and fully working mc questions
		question.destroy
		redirect_to(audience_path(audience))
	end


	#DO NOT USE, USE RESPONSE CONTROLLER
	def answer
		answer = MultipleChoiceAnswer.find(params[:mcid])
		questionjson = answer.multiple_choice_question.audience.broadcast
		#make below JSON the broadcat once broadcast sets
		if answer.multiple_choice_question.audience.isBroadcasting(answer.multiple_choice_question)
			#save answer
			render :text => 'save'
		else
			render :text => 'error'
		end
	end

	private

		def require_login
			unless user_signed_in?
				redirect_to(new_user_session_path)
			end
		end
end
