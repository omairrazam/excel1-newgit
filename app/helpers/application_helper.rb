module ApplicationHelper
	
	def nav_link(link_text, link_path, overwrite_path = nil)
	
		if overwrite_path.present?
		 	class_name = request.original_url.include?(overwrite_path)  ? 'active' : ''
		else
		  class_name = current_page?(link_path) ? 'active' : ''
		end
		link_to link_text, link_path, :class => "blog-nav-item " +  class_name
	end

	def ic_sidebar_link_class(id)
		class_name = ''
		if request.original_url.include?('category_id='+id.to_s)
			class_name = 'active'
		end
		class_name
	   # class_name = current_page?(link_path) ? 'active' : ''
	end

	def profile_active_link(link_path)
	  class_name = current_page?(link_path) ? 'active' : ''
	end

	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end
end
