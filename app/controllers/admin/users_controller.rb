class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!  # Ensure only admins can access this page

  def index
    @users = User.all  # Fetch all users from the database
  end

  def update_user_role
    user = User.find(params[:id])
    if user.update(role: params[:user][:role])
      flash[:notice] = "#{user.name}'s role has been updated to #{user.role}."
    else
      flash[:alert] = "Failed to update role."
    end
    redirect_to admin_users_path
  end

  def delete_user
    user = User.find(params[:id])
    if user.destroy
      flash[:notice] = "#{user.name} has been deleted."
    else
      flash[:alert] = "Failed to delete user."
    end
    redirect_to admin_users_path
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: "Access denied!" unless current_user&.role == "admin"
  end
end
