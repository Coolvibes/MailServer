
require 'rails_helper'

RSpec.describe Email, :type => :model do

  it "has a valid factory" do
     FactoryGirl.create(:email).should be_valid
  end

  it "is invalid without sender if not a draft " do

    FactoryGirl.build(:email,message:"hdghagfbhjfhfghfghffhdgfh",is_draft: false).should_not be_valid

    FactoryGirl.build(:email,message:"hdgha",is_draft: false).should_not be_valid

  end
   
end