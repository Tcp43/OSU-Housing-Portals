# File created 11/20 by Troy Paschal:Handles role-based access to profiles
# Edited 11/28/2024 by Troy Paschal: Added ability to add favorite to profile
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_role!, only: [ :student_profile, :landlord_profile ]

  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  # end

  # Created 11/20 by Troy Paschal
  # Action for student profile
  def student_profile
    @user = User.find(params[:id])
    if @user.student? || @user.admin?
      @favorites = @user.favorites.includes(:listing)
    else
      redirect_to root_path, alert: "Access denied."
    end
  end

  # Created 11/20 by Troy Paschal
  # Action for landlord profile
  def landlord_profile
    @user = User.find(params[:id])
    if @user.landlord? || @user.admin?
      @listings = @user.listings
    else
      redirect_to root_path, alert: "Access denied."
    end
  end
end
