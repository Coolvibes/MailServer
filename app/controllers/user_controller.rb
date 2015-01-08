class UserController < ApplicationController
  def home
  #we changed the route name
    @emails=Email.joins(:receivers).where(receivers: { receiver_email: current_user.email },is_draft: false).order(created_at: :desc).
        paginate(:page => params[:page], :per_page => 4)

    

  end
end
