class StaticpagesController < ApplicationController

	def index
		if user_signed_in?
			redirect_to(audiences_path)
		else
			render :layout => false
		end
	end

	def pricing 
	end

	def socket 
	end

end
