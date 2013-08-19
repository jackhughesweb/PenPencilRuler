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

  def users
    if params[:id].nil?
      @users = User.order("created_at").page(params[:page]).per(20)
    else
      @user = User.find(params[:id])
    end
    respond_to do |format|
      format.html {render :layout => 'admin'}
    end
  end

  def become
    return unless current_user.is_admin?
    sign_in(:user, User.find(params[:id]), {:bypass => true})
    redirect_to root_url
  end

  def suspend
    @suspenduser = User.find(params[:id])
    @suspenduser.suspended_by = current_user.id
    @suspenduser.is_suspended = true
    @suspenduser.save
    redirect_to admin_users_url(@suspenduser.id)
  end

  def unsuspend
    @unsuspenduser = User.find(params[:id])
    @unsuspenduser.suspended_by = ""
    @unsuspenduser.is_suspended = false
    @unsuspenduser.save
    redirect_to admin_users_url(@unsuspenduser.id)
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
