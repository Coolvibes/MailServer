class Receiver < ActiveRecord::Base

  belongs_to :email
  belongs_to :user

  validates :receiver_email, presence:true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.).[a-z]{2,})\Z/,
                                             message: "Enter valid email id only"},:if => :mail_is_sent?

  def mail_is_sent?
    !self.email.is_draft
  end

end


