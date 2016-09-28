class RegistrationsController < Devise::RegistrationsController
  def create
    super do
      
       
    end
  end

  def after_inactive_sign_up_path_for(resource)
    #debugger
    transaction = resource.transactions.create
    transaction.paypal_url(paypal_return_path)
  end

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation,:period,:agreed)
  end

end