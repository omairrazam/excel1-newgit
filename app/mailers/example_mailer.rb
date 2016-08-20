class ExampleMailer < ApplicationMailer
	default from: "from@example.com"
  
  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Stock Cloud
Research')
  end

  def admin_email(admin, new_user)
  	@user = admin
  	@new_user = new_user
    mail(to: @user.email, subject: 'New Subscriber on your site')
  end
end
