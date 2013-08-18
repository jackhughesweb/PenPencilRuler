class AdminController < ApplicationController
  before_filter :validate_user

  def index
    @newusercount = User.where("created_at > ?", Time.now-7.days).count
    @activeusercount = User.where("last_sign_in_at > ?", Time.now-7.days).count
    @emailunconfirmedusercount = User.where("confirmation_token <> ''").count
    respond_to do |format|
      format.html {render :layout => 'admin'}
    end
  end

  private

  def validate_user
    if user_signed_in?
      if current_user.is_admin?
        
      else
        redirect_to subjects_path, notice: 'Well done, you found the admin panel! Unfortunately, you are not an admin so you don\'t have permission to view it.'
      end
    else
      redirect_to root_path, notice: 'Well done, you found the admin panel! Unfortunately, you are not an admin so you don\'t have permission to view it.'
    end
  end
end
