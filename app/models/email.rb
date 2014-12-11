class Email < ActiveRecord::Base

  validates :sender, presence:true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.).[a-z]{2,})\Z/,
            message: "Valid email id only"}
  validates :message, length: { in: 0..10 }

  has_many :receivers

  belongs_to :user

  attr_accessor :receiver_email



  def is_read_by_all?

    #can directly be used by model objects then, no need to write separate queries

  end

  def allow_create?

    cnt=Email.where('created_at >= ?', 15.minutes.ago).count

    !(cnt>5)

    if (cnt>5 == true)
      return false
    else
      return true
    end

  end

end
