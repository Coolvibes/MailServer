require "rails_helper"

RSpec.describe InboxController, :type => :controller do

  before(:each) do
   
   #we stub the authenticate_user method to bypass authentication
   controller.stub(:authenticate_user!).and_return(true)
   @user = FactoryGirl.create(:user)
   controller.stub(:current_user).and_return(@user)

  end

 describe "testing delete_draft" do

   it "renders the draft template" do

    @email1=FactoryGirl.create(:email)

    get :delete_draft, :id=> @email1.id

    response.should redirect_to inbox_draft_path

  end

end

end