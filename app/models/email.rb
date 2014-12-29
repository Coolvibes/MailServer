class Email < ActiveRecord::Base

  has_many :receivers

  validates :sender, presence:true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.).[a-z]{2,})\Z/,
            message: "Valid email id only"},:if => :is_not_draft?
  validates :message, length: { in: 0..1000 },:if => :is_not_draft?
  validates :subject, presence:true, length: {in: 0..100}, :if => :is_not_draft?

  validates_presence_of :receivers, :if => :is_not_draft?

  #validate :allow_create?

  belongs_to :user

  attr_accessor :receiver_email

  def for_receivers?
    !self.receivers.blank?
  end


  def is_not_draft?
    self.is_draft==false
  end


  def allow_create?

    Email.where('created_at >= ?', 5.minutes.ago).where(is_draft: false).where(sender: self.sender).count< 5
  end

end
