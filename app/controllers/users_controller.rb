class UsersController < ApplicationController
	
	def show
		@user = current_user
	end

	def show_paypal_info
		@payments     = current_user.transactions.where('txn_type=?', "subscr_payment").page(params[:page]).per(10)
		@package      = PaypalPackage.find_by_subscription_type(current_user.period.first)
	end

	
end
