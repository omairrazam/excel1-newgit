class BaseAdminController < ApplicationController

	# cancan error resolving code on create method
	before_filter do
    	resource = controller_name.singularize.to_sym
    	method = "#{resource}_params"
    	params[resource] &&= send(method) if respond_to?(method, true)
  	end

	load_and_authorize_resource 
	
	
end