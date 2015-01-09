require 'rails_helper'

RSpec.describe Receiver, :type => :model do

  it "has a valid factory" do

     FactoryGirl.create(:receiver).should be_valid

  end

  it "is invalid without sender if not a draft " do
  	email_factory = FactoryGirl.build(:email, is_draft:false)
    FactoryGirl.build(:receiver,receiver_email:"hdgha", email: email_factory ).should_not be_valid
  end

  
end
