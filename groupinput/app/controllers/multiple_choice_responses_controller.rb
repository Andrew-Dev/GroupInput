class MultipleChoiceResponsesController < ApplicationController

	skip_before_filter :verify_authenticity_token
  	before_filter :cors_preflight_check
  	after_filter :cors_set_access_control_headers

	def create
		#responds to question
		response = MultipleChoiceResponse.new
		response.multiple_choice_answer = MultipleChoiceAnswer.find(params[:answerid])
		client = Client.find_by(token: params[:token])
		audience = response.multiple_choice_answer.multiple_choice_question.audience
		question = response.multiple_choice_answer.multiple_choice_question
		if audience.isBroadcasting(question) && audience.verifyClient(client) && !question.checkDuplicateResponses(client)
			response.client = client
			if response.save
				render :text => "success"
			else
			    render :text => "fail"
			end
		else
		    render :text => "fail"
		end
	end

	private

	  def cors_set_access_control_headers
	    headers['Access-Control-Allow-Origin'] = '*'
	    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
	    headers['Access-Control-Max-Age'] = "1728000"
	  end

	  def cors_preflight_check
	    headers['Access-Control-Allow-Origin'] = '*'
	    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
	    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
	    headers['Access-Control-Max-Age'] = '1728000'
	  end
end
