class CalendarAuthController < ApplicationController
	
	def create
		redirect_to: auth_two
	end

	def auth_two
		auth_uri = auth_client.authorization_uri.to_s
	end
end