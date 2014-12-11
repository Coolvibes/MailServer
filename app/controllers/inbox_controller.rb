class InboxController < ApplicationController
  def view
    @emails=Email.joins(:receivers).where(receivers: { receiver_email: current_user.email }).
        paginate(:page => params[:page], :per_page => 4)

    # @page = Email.paginate(:email => params[:email], :per_page => 4)

    puts @emails.all
  end

  def sent
    @emails=Email.where(:sender=> current_user.email).paginate(:page => params[:page], :per_page => 4)
    #@page = Email.paginate(:email => params[:email], :per_page => 4)
  end


  ## Show page of a single email
  def show_msg

    @email = Email.find(params[:id])

    read =params[:read]
    #@email.receivers.update_attribute(:is_read, read)

    puts @email

    r=Receiver.where(email_id: @email.id,receiver_email: current_user.email)

    puts read
    puts "++++++++++++++++"
    puts r

    if(r.blank? == false)
      Receiver.update(r.first.id,is_read: read)
    end

  end
end
