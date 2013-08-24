class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    if current_user.deletion_allowed?
      super
    else
      redirect_to edit_user_registration_path
    end 
  end 
end
