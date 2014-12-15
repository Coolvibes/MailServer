class Email < ActiveRecord::Base

  validates :sender, presence:true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.).[a-z]{2,})\Z/,
            message: "Valid email id only"},:if => :is_not_draft?
  validates :message, length: { in: 0..200 },:if => :is_not_draft?
  validates :subject, length: {in: 0..20}, :if => :is_not_draft?

  has_many :receivers

  belongs_to :user

  attr_accessor :receiver_email


  def is_not_draft?

    return is_draft==false

  end



  def is_read_by_all?

    #can directly be used by model objects then, no need to write separate queries

  end

  def allow_create?

    cnt=Email.where('created_at >= ?', 15.minutes.ago).count

    !(cnt>5)

    #if (cnt>5 == true)
    #  return false
    #else
    #return true
    #end

  end

end
