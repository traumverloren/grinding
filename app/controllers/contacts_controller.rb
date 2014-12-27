class ContactsController < ApplicationController

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(secure_params)
    if @contact.valid?
      UserMailer.contact_email(@contact).deliver
      flash.now[:success] = "Message sent from #{@contact.name}."
      redirect_to new_contact_path
    else
      flash.now[:danger] = "Message not sent.  Please see errors below."
      render :new
    end
  end


  private

  def secure_params
    params.require(:contact).permit(:name, :email, :phone, :message)
  end

end
