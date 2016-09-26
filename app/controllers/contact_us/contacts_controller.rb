class ContactUs::ContactsController < ApplicationController
  before_filter :authenticate_user!, except:[:create, :new]
  skip_authorize_resource except: :create
  skip_authorization_check

  def create
    @contact = ContactUs::Contact.new(params[:contact_us_contact])

    if @contact.save
      redirect_to(ContactUs.success_redirect || '/', :notice => t('contact_us.notices.success'))
    else
      flash.now[:alert] = t('contact_us.notices.error')
      render_new_page
    end
  end

  def new
    @contact = ContactUs::Contact.new
    render_new_page
  end

  protected
    def render_new_page
      case ContactUs.form_gem
      when 'formtastic'  then render 'new_formtastic'
      when 'simple_form' then render 'new_simple_form'
      else
        render 'new'
      end
    end
end