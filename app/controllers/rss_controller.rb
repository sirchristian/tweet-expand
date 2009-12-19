class RssController < ApplicationController
	def index
		@username = params[:user] 
	end
end
