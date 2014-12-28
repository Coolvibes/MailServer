require "rails_helper"

RSpec.describe EmailsController, :type => :controller do

  #controller.stub(:before_action) {authenticate_user!}
  before(:each) do
   # controller.class.skip_before_action

   controller.stub(:authenticate_user!).and_return(true)
   @user = FactoryGirl.create(:user)
   controller.stub(:current_user).and_return(@user)

  end

  describe "test_ajax action testing" do

    it "finds the email correctly" do

      @email1=FactoryGirl.create(:email, id:2016)
      # Email.stub(:find).and_return(email1)

      post :test_ajax, id:@email1.id, :format => :json

      email=Email.find(controller.params[:id])

      #email= FactoryGirl(:email,id:controller.params[:id])

      email.id.should eq @email1.id
      #assigns(:email).id.should eq email1.id
    end

    it "renders JSON with correct hash" do

      @expected ={
          :json=> nil,
          :status=> :ok
      }.to_json

      @email1=FactoryGirl.create(:email, id:2016)

      post :test_ajax, :format=> :json,:id=> @email1.id

      #FactoryGirl.build(:email)
      response.status.should eq 200
      response.body.should == "null"

    end

    it "checks for failure to save" do

      @email1=FactoryGirl.create(:email, id:2016)
      #controller.instance_variable_set(:@email,@email1)

      #set(:email) { FactoryGirl(:email,id:2017,sender:"kdkdkdk") }

      post :test_ajax, :format=> :json,:id=> @email1.id,:subject=>"hjsdhj"

      #controller.instance_variable_set(:@email.sender,"kjfkjgfj")


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

      #email = FactoryGirl.create(:email)
      #expect{ post :create, email: FactoryGirl.attributes_for(:email) }.to change(Email,:count).by(1)
      #assigns(:email).should be_a_new(Email)
      assigns(:email).is_draft.should eq true
      # be_a_new(Email).with(:is_draft => true)
      # expect{ get :new }.to change(Email,:count).by(1)
      end

      it "creates an empty draft and renders the new view" do
      #draft = FactoryGirl(:email)

        #FactoryGirl.create(:email)
         #post :create, email: FactoryGirl.attributes_for(:email)
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

    # it "loads all of the posts into @posts" do
    #   post1, post2 = Post.create!, Post.create!
    #   get :index
    #
    #   expect(assigns(:posts)).to match_array([post1, post2])
    # end
  end

  end




