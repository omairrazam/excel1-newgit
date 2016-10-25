class ExampleMailer < ApplicationMailer
	default from: "from@example.com"
  
  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to IndextResearch')
  end

  def payment_fail_email(user)
    @user = user
    mail(to: @user.email, subject: 'Payment Failure - Account Suspension Notice')
  end

  def admin_email(admin, new_user)
  	@user = admin
  	@new_user = new_user
    mail(to: "scr.ownerr@gmail.com", subject: 'New Subscriber on your site')
  end

  def account_suspend_email(user)
    @user = user
    mail(to: @user.email, subject: 'Payment Failure - Account Suspended')
  end

  def test_email(new_user, type)
    
    @type = type
    @new_user = new_user
    mail(to: "omairr.azam@gmail.com", subject: type)
  end


end
