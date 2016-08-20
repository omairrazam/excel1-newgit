class RegistrationsController < Devise::RegistrationsController
  def create
    super do
      #debugger
      # @user = User.new(email: params[:user][:email], password: params[:user][:password])
      # if @user.valid?
      #   redirect_to Transaction.paypal_url(paypal_return_path,request,@user)
      # end
    end
  end

   def after_inactive_sign_up_path_for(resource)
    #debugger
      transaction = resource.transactions.create
      transaction.paypal_url(paypal_return_path)
  end

end