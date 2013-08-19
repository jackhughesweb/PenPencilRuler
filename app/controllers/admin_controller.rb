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
      if params[:search].nil?
        @users = User.order("created_at").page(params[:page]).per(20)
      else
        @search = params[:search]
        @users = User.where('name LIKE ? OR email LIKE ?', "%#{@search}%", "%#{@search}%").order("created_at").page(params[:page]).per(20)
      end
    else
      @user = User.find(params[:id])
    end
    respond_to do |format|
      format.html {render :layout => 'admin'}
    end
  end

  def become
    return unless current_user.is_admin?
    @becomeuser = User.find(params[:id])
    if !@becomeuser.is_admin?
      sign_in(:user, User.find(params[:id]), {:bypass => true})
      redirect_to root_url
    else
      redirect_to admin_users_url(@becomeuser.id)
    end
  end

  def suspend
    @suspenduser = User.find(params[:id])
    if !@suspenduser.is_admin?
      @suspenduser.suspended_by = current_user.id
      @suspenduser.is_suspended = true
      @suspenduser.save
    end
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
