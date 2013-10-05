class SearchController < ApplicationController
  before_filter :validate_user

  def index
    if params.has_key?(:search)
      @query = params[:search]
      @user = User.find(current_user.id)
      @notes = @user.notes.where("text ILIKE '%' || ? || '%'", @query).page(params[:page]).per(2)
    end
    respond_to do |format|
      format.html
    end
  end

  private

  def validate_user
    if user_signed_in?
      if current_user.is_admin?
        
      else
        redirect_to subjects_path, flash: { error: 'Someday you might become an admin, but until then you can\'t visit this page.' }
      end
    else
      redirect_to root_path, flash: { error: 'Someday you might become an admin, but until then you can\'t visit this page.' }
    end
  end
end
