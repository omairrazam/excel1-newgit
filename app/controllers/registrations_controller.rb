class RegistrationsController < Devise::RegistrationsController
  def create
    super do

      

      # if params["terms"]["accepted"] == "no"
      #   #debugger
      #   flash[:alert] = "You must agree with terms and conditions"
      #   render :new
      #   return
      # end
      
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

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation,:period,:agreed)
  end

end