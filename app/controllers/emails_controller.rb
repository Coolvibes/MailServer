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

  end



   def create
     #creates as well as saves the information
     @email = Email.new(email_params) #email_params is a hash
     @email.sender = current_user.email

     #.merge({:sender => current_user.email}), used above
     puts "=============="
     puts current_user

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
     if @email.allow_create?
       if @email.save

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
   end

  private
    def email_params
     #permits the use of these attributes for all the functions
     params.require(:email).permit(:subject,:message)
    end
   #Email.create(params[:email]).permit(:receiver,:sender,:message)
 end

