class Email < ActiveRecord::Base

  validates :sender, presence:true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.).[a-z]{2,})\Z/,
            message: "Valid email id only"},:if => :is_not_draft?
  validates :message, length: { in: 0..10 },:if => :is_not_draft?
  validates :subject, length: {in: 0..20}, :if => :is_not_draft?

  has_many :receivers

  belongs_to :user

  attr_accessor :receiver_email


  def is_not_draft?
    is_draft==false
  end


  def allow_create?
    Email.where('created_at >= ?', 15.minutes.ago).where(is_draft: false).count < 5
  end

end
