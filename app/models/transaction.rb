class Transaction < ActiveRecord::Base
	belongs_to :user
	 def paypal_url(return_path)
	 	package = PaypalPackage.find_by_subscription_type(user.period.first)

	    values = {
	    	#ip: request.remote_ip,
	        business: "#{Rails.application.secrets.facilitator_account}",
	        no_shipping: 1,
	        upload: 1,
	        return: "#{Rails.application.secrets.app_host}#{return_path}",
	        invoice: id,
	        item_name: user.email,
	        notify_url: "#{Rails.application.secrets.app_host}/hook",  
	        cmd: "_xclick-subscriptions",
            a3: package.amount,
            p3: 1,  # repeat every t3 value e.g for M, 1 means repeat every month
            src: 1, # recurring payments, 1 for true
            #srt: package.cycles, #Recurring times. 
            srt: 52,
            t3: user.period.first,
            #t3: 'D' # monthly or daily
            #rm:2
	    }

	    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  	end  
end
