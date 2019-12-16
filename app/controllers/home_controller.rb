class HomeController < ApplicationController
  def index
  end

  def contact
  end

  #Holds the contact information to be passed through the mailer to be sent.
  def request_contact
    name = params[:name]
    email = params[:email]
    telephone = params[:telephone]
    message = params[:message]
    if email.blank?
      flash[:alert] = I18n.t('home.request_contact.no_email')
    else
      # Sends an email
      ContactMailer.contact_email(email, name, telephone, message).deliver_now
      flash[:notice] = I18n.t('home.request_contact.email_sent')
      end
    redirect_to root_path
  end


end
