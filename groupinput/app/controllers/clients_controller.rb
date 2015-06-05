class ClientsController < ApplicationController

	skip_filter *_process_action_callbacks.map(&:filter)
	
	def create
		@client = Client.new
		@client.generateToken
		headers['Access-Control-Allow-Origin'] = '*'
		if @client.save
			render :plain => @client.token
		else
			render :plain => "fail"
		end
	end

	def destroy
		headers['Access-Control-Allow-Origin'] = '*'
		client = Client.find(params[:id])
		client.destroy
		render :plain => "success"
	end
end
