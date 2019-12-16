class RegistrationsController < Devise::RegistrationsController



  private
  #Passes in user information and strictly passes in the required fields into the user database
  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  #Passes in the updated user information to the user's account
  def account_update_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password)
  end

end
