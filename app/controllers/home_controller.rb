class HomeController < ApplicationController
	before_filter :authenticate_user!, only:[]
	
	def recruitment
	end
end
