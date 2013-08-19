class PagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to subjects_url
    else
      respond_to do |format|
        format.html {render :layout => 'index'}
      end
    end
  end

  def suspended
    if user_signed_in?
      if current_user.is_suspended?
        respond_to do |format|
          format.html {render :layout => 'application'}
        end
      else
        redirect_to subjects_url
      end
    else
      redirect_to root_url
    end
  end
end
