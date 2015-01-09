require "rails_helper"

RSpec.describe EmailsController, :type => :controller do

  before(:each) do
   
   #we stub the authenticate_user method to bypass authentication
   controller.stub(:authenticate_user!).and_return(true)
   @user = FactoryGirl.create(:user)
   controller.stub(:current_user).and_return(@user)

  end

  describe "test_ajax action testing" do

    it "finds the email correctly" do

      @email1=FactoryGirl.create(:email, id:2016)
      
      post :test_ajax, id:@email1.id, :format => :json, :receiver=>"medha@josh.com"

      email=Email.find(controller.params[:id])

      email.id.should eq @email1.id
      
    end

    it "renders JSON successfully with correct hash" do

      @expected ={
          :json=> nil,
          :status=> :ok
      }.to_json

      @email1=FactoryGirl.create(:email, id:240)

      post :test_ajax, :format=> :json,:id=> @email1.id, :receiver=>"medha@josh.com"

      response.status.should eq 200
      response.body.should == "null"

    end

    it "checks for successful save" do

      @email1=FactoryGirl.create(:email, id:240)
      

      post :test_ajax, :format=> :json,:id=> @email1.id,:subject=>"hjsdhj", :receiver=>"medha@josh.com"

      assigns(:email).should be_a(Email)

      #assigns(:email).should be_a(Email).with(:sender=> "hjsdhj"*100)

      assigns(:email).should be_valid
      assigns(:email).subject.should eq "hjsdhj"

    end

  end

  describe "new action" do

    it "new creates a new email entry" do

      old_count = Email.count
      get :new
      new_count = Email.count
      new_count.should eq (old_count+1)

      assigns(:email).is_draft.should eq true
      
      end

      it "creates an empty draft and renders the new view" do
    
        get :new

        response.status.should eq 200
        response.should render_template :new

     end

  end

  describe "edit action" do

    it "finds the email from the database by id" do
    email = Email.create

    get :edit, id:email.id

    email1= Email.find(controller.params[:id])

    #email1= Email.find(email.id)

    email1.id.should eq email.id
    end

end

  describe "index action" do

     it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

end




