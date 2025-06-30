# Created 11/24/2024 by Koury Harmon: Controller for landing page functionality (home page)
# Edited 11/28/2024 by Koury Harmon: added dashboard function
# Edited 12/1/2024 by Koury Harmon: switched from proj_pages controller to landing controller
class LandingController < ApplicationController
  # Created 11/24/2024 by Koury Harmon: Defines the landing page for unregistered users
  def home
    @listings = Listing.all
    if user_signed_in?
      redirect_to dashboard_path
    end
  end

  # Created 11/28/2024 by Koury Harmon: Defines landing page for registered users
  def dashboard
    @listings = Listing.all
    @user = current_user
    if user_signed_in?
      if @user.student?
        @favorites = @user.favorites.includes(:listing)
      elsif @user.landlord?
        @listings = @user.listings
      elsif @user.admin?
        @favorites = @user.favorites.includes(:listing)
        @listings = @user.listings
      end
    else
      redirect_to home_path, alert: "You must be signed in to view your dashboard."
    end
  end
end
