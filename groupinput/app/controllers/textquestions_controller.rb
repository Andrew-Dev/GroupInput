class TextquestionsController < ApplicationController

	def index
		@audience = Audience.find(params[:audience_id])
		redirect_to(audience_path(@audience))
	end

	def new
		@audience = Audience.find(params[:audience_id])
		@question = Textquestion.new
	end
	
	def create
		question = Textquestion.new
		question.question = params[:textquestion][:question]
		question.audience = Audience.find(params[:audience_id])
		audience = Audience.find(params[:audience_id])
		if question.save
			redirect_to(audience_textquestion_path(audience,question))
		else
			errors = ""
			question.errors.each do |e|
				errors = errors
			end
			flash[:danger] = question.errors.full_messages.join("")
			redirect_to(new_audience_textquestion_path(audience))
		end
	end
	
	def show
		@audience = Audience.find(params[:audience_id])
		@question = Textquestion.find(params[:id])
		@questionjson = @question.to_json
	end
	
	def destroy
		@question = Textquestion.find(params[:id])
		audience = @question.audience
		@question.destroy
		redirect_to(audience_path(audience))
	end
end
