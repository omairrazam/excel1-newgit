# Use this hook to configure contact mailer.
ContactUs.setup do |config|

  # ==> Mailer Configuration

  # Configure the e-mail address which email notifications should be sent from.  If emails must be sent from a verified email address you may set it here.
  # Example:
  # config.mailer_from = "contact@please-change-me.com"
  config.mailer_from = "dontreply@yourdomain.com"

  # Configure the e-mail address which should receive the contact form email notifications.
  config.mailer_to = "scr.ownerr@gmail.com"

  # ==> Form Configuration

  # Configure the form to ask for the users name.
  config.require_name = true

  # Configure the form to ask for a subject.
  config.require_subject = true

  # Configure the form gem to use.
  # Example:
  # config.form_gem = 'formtastic'
  #config.form_gem = 'simple_form'

  # Configure the redirect URL after a successful submission
  config.success_redirect = '/'

  # Configure the parent action mailer
  # Example:
  # config.parent_mailer = "ActionMailer::Base"

end

ContactUs::ContactsController.class_eval do
  def create
    @contact = ContactUs::Contact.new(params[:contact_us_contact])

    if @contact.save
      redirect_to(ContactUs.success_redirect || '/', :notice => t('contact_us.notices.success'))
    else
      flash.now[:alert] = t('contact_us.notices.error')
      render_new_page
    end
  end
end