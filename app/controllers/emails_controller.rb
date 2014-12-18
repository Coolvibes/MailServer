class EmailsController < ApplicationController
  def compose
  end

  def index
    #all mails recieves all the emails and can be used to create the sent functionality
    @all_mails=Email.all
    puts "******************"
    puts @all_mails.first.attributes

  end

  def new
    #email is my mail table
    #new only generates a new object
    @email=Email.new
    @email.is_draft=true
    #@email.subject="Enter subject here"
    @email.save
    # Email.create ( draft true)

  end

  def edit

    @email=Email.find(params[:id])
    @r= params[:r]

    puts "66666666666"
    puts params[:subject]

    # @email.update(subject:params[:subject],message:params[:message],sender:current_user.email)

  end

  def update
    puts "^^^^^^^^^^^^^^"
    puts params[:email][:id]

    @email = Email.find(params[:email][:id]) #email_params is a hash
    #@email.sender = current_user.email
    @email.update(subject:params[:email][:subject],message:params[:email][:message],sender:current_user.email)

    #.merge({:sender => current_user.email}), used above
    puts "=============="
    puts current_user

    #purge old receivers before every new updation
    @email.receivers.each do |x|
      x.destroy
    end

    #taking comma separated list of receivers and separating them
    @receiver = params[:email][:receiver_email].split(',')

    @receiver.each do |r|
      @email.receivers.new(:receiver_email => r)
      # b.save .merge({:sender => current_user.email})
    end

    #puts email_params
    #@recipients = @email.receiver.split(',')

    #@recipients.each do |r|
    # newmail= @email.new(:receiver=>r)
    #newmail.save
    #end
    # if params[:commit] == "send"

    puts "++++++++++++++"
    puts params[:commit]
    #send email or save as draft functionality

    if params[:commit] == "Send"


      if @email.allow_create?

        #@email.is_draft=false

        if @email.update(is_draft:false)

          redirect_to :action => 'index', alert: "Mail sent successfully."
          # UserMailer.send_email(@email).deliver
          #redirect_to :action => 'index', alert: "Mail sent successfully."
        else
          redirect_to new_email_path, alert: "Error sending mail."
        end

      else  redirect_to new_email_path, alert:"Cannot send more than 5 messages in 15 mins.!!"
      end
      #@email.save
      #redirect_to @email
      #@email= Email.create(params[:email]).permit(:receiver,:sender,:message)

    else

      #@email.is_draft=true

      if @email.update(is_draft:true)

        redirect_to :action => 'index', alert: "Draft successfully saved!"
      else
        redirect_to new_email_path, alert: "Draft not saved, try again!"
      end

    end

    @trial = Email.find(@email.id)

    puts "8888888888888888"
    puts @trial
    #@draft=Email.new
    #@draft.is_draft=true
    ##code for deactivating validation
    #@draft.save

  end



   # def create
   #   #creates as well as saves the information
   #
   #   puts "^^^^^^^^^^^^^^"
   #   puts params[:email][:id]
   #
   #   @email = Email.new(email_params) #email_params is a hash
   #   @email.sender = current_user.email
   #
   #   #.merge({:sender => current_user.email}), used above
   #   puts "=============="
   #   puts current_user
   #
   #
   #   #taking comma separated list of receivers and separating them
   #   @receiver = params[:email][:receiver_email].split(',')
   #
   #   @receiver.each do |r|
   #     @email.receivers.new(:receiver_email => r)
   #     # b.save .merge({:sender => current_user.email})
   #   end
   #
   #   #puts email_params
   #   #@recipients = @email.receiver.split(',')
   #
   #   #@recipients.each do |r|
   #   # newmail= @email.new(:receiver=>r)
   #     #newmail.save
   #   #end
   #  # if params[:commit] == "send"
   #
   #     puts "++++++++++++++"
   #     puts params[:commit]
   #  #send email or save as draft functionality
   #
   #   if params[:commit] == "Send"
   #
   #
   #     if @email.allow_create?
   #
   #       @email.is_draft=false
   #
   #       if @email.save
   #
   #         redirect_to :action => 'index', alert: "Mail sent successfully."
   #         # UserMailer.send_email(@email).deliver
   #         #redirect_to :action => 'index', alert: "Mail sent successfully."
   #       else
   #         redirect_to new_email_path, alert: "Error sending mail."
   #       end
   #
   #     else  redirect_to new_email_path, alert:"Cannot send more than 5 messages in 15 mins.!!"
   #     end
   #     #@email.save
   #     #redirect_to @email
   #     #@email= Email.create(params[:email]).permit(:receiver,:sender,:message)
   #
   #   else
   #
   #     @email.is_draft=true
   #
   #     if @email.save
   #
   #       redirect_to :action => 'index', alert: "Draft successfully saved!"
   #     else
   #       redirect_to new_email_path, alert: "Draft not saved, try again!"
   #     end
   #
   #   end
   #
   #   @trial = Email.find(@email.id)
   #
   #   puts "8888888888888888"
   #   puts @trial
   # end




  private
    def email_params
     #permits the use of these attributes for all the functions
     #no need to permit
     params.require(:email).permit(:subject,:message,:id)
    end
   #Email.create(params[:email]).permit(:receiver,:sender,:message)

 end

