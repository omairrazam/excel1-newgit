class SubsciptionsController < ApplicationController
  def create
  	package = params[:package]
  	current_user.period = package
  	current_user.save
  	
  	transaction = current_user.transactions.create
    redirect_to transaction.paypal_url(paypal_return_path)
  end
end
