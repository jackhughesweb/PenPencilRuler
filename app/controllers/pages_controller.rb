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
end
