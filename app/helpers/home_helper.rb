module HomeHelper
	def get_notification_class name
		if name == "notice"
			clas = "info"
		elsif name == "alert"
			clas = "error"
		elsif name == "success"
			clas = "success"
		end
		clas	
	end
end
