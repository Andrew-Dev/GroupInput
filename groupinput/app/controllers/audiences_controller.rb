class AudiencesController < ApplicationController

	before_action :require_login
	after_action :cors_set_access_control_headers
	skip_before_action :require_login, only: [:showbroadcast,:addclient,:code]

	def index
		if user_signed_in?
			@audiences = current_user.audiences
			respond_to do |format|
	          format.html # index.html.erb
	          format.xml  { render :xml => @audiences }
	          format.json { render :json => @audiences }
	        end
		else
			redirect_to('/')
		end
	end

	def show
		@audience = Audience.find(params[:id])
		if @audience.user == current_user
			respond_to do |format|
	          format.html # index.html.erb
	          format.xml  { render :xml  => @audience }
	          format.json { render :json => @audience }
	        end
	    else
	    	redirect_to('/')
	    end
	end

	def new
		@audience = Audience.new
	end

	def create
		@audience = Audience.new(audience_params)
		if @audience.save
			@audience.user = current_user
			@audience.generateCode
			@audience.save
			redirect_to(@audience)
		else
			errors = ""
			@audience.errors.each do |e|
				errors = errors
			end
			flash[:danger] = @audience.errors.full_messages.join("")
			render 'new'
		end
	end

	def destroy
		audience = Audience.find(params[:id])
		if audience.user == current_user
			audience.destroy
			redirect_to(audiences_path)
		else
			redirect_to(audiences_path)
		end
	end

	def code
		@audience = Audience.find_by(code: params[:code])
		client = Client.find_by(token: params[:token])
		headers['Access-Control-Allow-Origin'] = '*'
		if @audience && client
			if @audience.verifyClient(client)
				render :json => @audience
			else
				if !client.audiences.include?(@audience)
					client.audiences << @audience
					client.save
					render :json => @audience
				else
					render :json => @audience
				end
			end
		else
			render :json => "error"
		end
	end

	def showbroadcast
		@audience = Audience.find_by(code: params[:code])
		headers['Access-Control-Allow-Origin'] = '*'
		if @audience.broadcast == nil
			render :text => "none"
		else
			headers['Access-Control-Allow-Origin'] = '*'
			render :text => @audience.broadcast
		end
	end

	def setbroadcast
		audience = Audience.find_by(code: params[:code])
		if audience.user == current_user
			audience.broadcast = params[:questionjson]
			if audience.save
				render :plain => "success"
			else
				render :plain => "fail"
			end
		else
			render :plain => "fail"
		end
	end

	def stopbroadcast
		audience = Audience.find_by(code: params[:code])
		audience.broadcast = nil
		if audience.save
			render :text => "success"
			render :text => "fail"
		end
	end

	private
		def audience_params
			params.require(:audience).permit(:title)
		end

		def require_login
			unless user_signed_in?
				redirect_to(new_user_session_path)
			end
		end

		def cors_set_access_control_headers
			headers['Access-Control-Allow-Origin'] = '*'
       		headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
        	headers['Access-Control-Allow-Headers'] = %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(',')
        	headers['Access-Control-Max-Age'] = "1728000"
		end
end
