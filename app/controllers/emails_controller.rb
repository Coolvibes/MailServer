class EmailsController < ApplicationController

  def compose
  end

  def index
    #all_mails receives all the emails and can be used to create the sent functionality
    @all_mails=Email.all

  end

  def new

    #Here we create an empty mail as soon as the new action is hit

    @email=Email.new
    @email.is_draft=true
    @email.save

  end

  def edit

    #to render the same page again on unsuccessful save

    @email=Email.find(params[:id])
    @r= params[:r]


    #not doing @email.update(subject:params[:subject],message:params[:message],sender:current_user.email)
    #as we just need to pass the received parameters to the form again

  end

  def test_ajax

    #draft function refactored by AJAX

    @email= Email.find(params[:id])
    @email.subject = params[:subject]
    @email.message = params[:message]
    @email.sender = current_user.email
    @email.is_draft = true
    @email.created_at = Time.now

    @email.receivers.each do |x|
      x.destroy
    end

    @receiver = params[:receiver].split(',')

    @receiver.each do |r|

      #removing spaces from the beginning of a receiver
      s=r.lstrip
      @email.receivers.new(:receiver_email => s)

    end

    if @email.save
      respond_to do |format|
        format.json { render :json=> nil, status: :ok }
      end

    else
      respond_to do |format|
        format.json { render :json => @email.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    #this action is hit after any submit with an id from the 'new' form


    #email_params is a hash
    @email = Email.find(params[:email][:id])


    #purge old receivers before every new update
    @email.receivers.each do |x|
      x.destroy
    end


    #taking comma separated list of receivers and separating them
    @r= params[:email][:receiver_email]
    @receiver = params[:email][:receiver_email].split(',')

    
    @receiver.each do |r|

      #removing spaces from the beginning of a receiver
      s=r.lstrip
      @email.receivers.new(:receiver_email => s)

    end

    #common update required both in case of email and draft
    @email.subject = params[:email][:subject]
    @email.message = params[:email][:message]
    @email.sender = current_user.email


    #send email or save as draft functionality

    #if params[:commit] equals Send
    if params[:commit] == "Send"

      if @email.allow_create?

        @email.is_draft = false
        @email.created_at= Time.now

        if @email.save
          flash[:notice] = "Mail sent successfully."
          redirect_to root_path

          #for actually sending the email, currently not working
          # UserMailer.send_email(@email).deliver

        else

          #flash[:alert] = @email.errors.full_messages
          render :edit

        end
      else  
        flash[:alert] = "Cannot send more than 5 messages in 15 mins.!!"
        render :edit
        #alert:"Cannot send more than 5 messages in 15 mins.!!"
      end

      #@email= Email.create(params[:email]).permit(:receiver,:sender,:message)


      #if params[:commit] does not equal send
    elsif params[:commit] == "Draft"


      @email.is_draft = true
      @email.created_at = Time.now

          if @email.save

        flash[:notice] = "Draft successfully saved!"
        redirect_to root_path
      else

        render :edit, alert:"Draft not saved, try again!"
      end

    end


  end



   def create
   
   end


  private

    def email_params
     #permits the use of these attributes for all the functions
      params.require(:email).permit(:subject,:message,:id)
    end
end

