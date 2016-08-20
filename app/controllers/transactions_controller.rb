class TransactionsController < ApplicationController
	protect_from_forgery except: [:hook]
	before_filter :authenticate_user!, except: [:paypal_hook,:paypal_return]
	def show
		@transaction = Transaction.find params[:id]
	end

	def paypal_hook
		#debugger
		params.permit! # Permit all Paypal input params
		status = params[:payment_status]
		type = params[:txn_type]
	    
	    if status == "Completed" and type == "subscr_payment"
	      u = User.find_by_email(params['item_name'])
	      if u.present?
		      u.transactions.build(paypal_hook_params)
		   	  u.save!
		   end
		elsif type == "subscr_signup"
			u = User.find_by_email(params['item_name'])
			if u.present?
				u.account_active = true
				u.transactions.build(paypal_return_params)
				u.save!
			end

		   	
	    end
	    render nothing: true
	end

	def paypal_return
		#debugger
		auth = params["auth"]
		if auth.present?
			u = User.last
			
				u.account_active = true
				u.transactions.build(:auth=> auth)
				u.save!
				# Sends email to user when user is created.
      			ExampleMailer.sample_email(u).deliver
      			admin = User.find_by_email("scr.ownerr@gmail.com")
      			ExampleMailer.admin_email(admin,u).deliver
				flash.clear
				flash[:success] =  "Thanks for subscribing, you can view your subscription details in Settings. You are now logged in"
				sign_in_and_redirect(u)
			
			    
		else
			flash.clear
			flash[:success] =  "Transaction was not processed"
			redirect_to root_path
		end
		
		
		#redirect_to root_path , flash: {notice: "Please verify through email"}
	end

	private

	def paypal_return_params
		params.permit(:txn_type, :subscr_id,:last_name, :residence_country,
					  :mc_currency, :item_name, :bussiness, :amount3,
					  :recurring, :payer_status, :payer_email, :first_name, 
					  :receiver_email, :payer_id,  :invoice, :reattempt,
					  :recur_times, :subscr_date, :charset, :period3, :mc_amount3,
					  :auth
					  )
	end

	def paypal_hook_params
		params.permit(:transaction_subject,:payment_date,
					  :txn_type,:subscr_id, :last_name,
					  :residence_country, :item_name,
					  :payment_gross, :mc_currency,
					  :bussiness, :payment_type, :protection_eligibility,
					  :verify_sign, :payer_status, :test_ipn, :payer_email,
					  :txn_id, :receiver_email, :first_name, :invoice,
					  :payer_id, :receiver_id, :payment_status, :payment_fee,
					  :mc_fee, :mc_gross, :notify_version, :ipn_track_id

					  )
	end
end
