class User < ActiveRecord::Base
  # Include default user modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :emails
  has_many :receivers, :through => :emails
end
