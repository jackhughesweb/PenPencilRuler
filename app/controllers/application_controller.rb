class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :validate_user

  private

  def validate_user
    if user_signed_in?
      if current_user.is_suspended?
        if params[:action] == "suspended"
          
        else
          if params[:action] == "destroy"

          else
            redirect_to suspended_path
          end
        end
      end
    end
  end
end
