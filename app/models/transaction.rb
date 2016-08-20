class Transaction < ActiveRecord::Base
	belongs_to :user
	 def paypal_url(return_path)
	 	
	    values = {
	    	#ip: request.remote_ip
	        business: "omairr.azam-facilitator@gmail.com",
	        no_shipping: 1,
	        upload: 1,
	        return: "#{Rails.application.secrets.app_host}#{return_path}",
	        invoice: id,
	        item_name: user.email,
	        notify_url: "#{Rails.application.secrets.app_host}/hook",  
	        cmd: "_xclick-subscriptions",
            a3: 12,
            p3: 1,
            srt: user.cycles,
            t3: user.period.first,
            #rm:2
	    }
	
	    #debugger
	    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  	end  
end
