class InboxController < ApplicationController

  def view
    #def to display the inbox
    @emails=Email.joins(:receivers).where(receivers: { receiver_email: current_user.email }).order(created_at: :desc).
        paginate(:page => params[:page], :per_page => 4)

  end

  def sent
    #def to display sent mail
    @emails=Email.where(:sender=> current_user.email,:is_draft => false).order(created_at: :desc).paginate(:page => params[:page], :per_page => 4)

  end

  def draft

    #this query cant be same as query for sent, as it will retrieve all and display only the ones
    #with is_draft=true as per current logic, rather add this in the controller query itself
    @emails=Email.where(:sender => current_user.email,:is_draft => true).order(created_at: :desc).paginate(:page => params[:page], :per_page => 4)


  end

  def delete_draft

    e=Email.find(params[:id])

    if e.destroy
      redirect_to inbox_draft_path, alert: "Draft deleted!"
    else
      redirect_to inbox_draft_path, alert: "Could not delete draft!"
    end

  end


  def show_msg

    #Shows the page with full contents of a single email
    #also handles the is_read and is_read_by_all function

    @email = Email.find(params[:id])
    read =params[:read]

    r=Receiver.where(email_id: @email.id,receiver_email: current_user.email)


    if(r.blank? == false)
      Receiver.update(r.first.id,is_read: read)
    end

  end
end
