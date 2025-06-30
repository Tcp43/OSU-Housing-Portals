# Created 11/28/2024 by Troy Paschal: Populate and and destory favorited listings
# Edited 11/29/2024 by Koury Harmon: Changed redirect to go back to student profile
class FavoritesController < ApplicationController
    before_action :authenticate_user!

    def create
        listing = Listing.find(params[:listing_id])
        current_user.favorites.create(listing: listing)
        redirect_back fallback_location: student_profile_path(current_user), notice: "Listing has been added to your favorites."
    end

      def destroy
        listing = Listing.find(params[:listing_id])
        favorite = current_user.favorites.find_by(listing: listing)
        favorite.destroy if favorite
        redirect_back fallback_location: student_profile_path(current_user), notice: "Listing has been removed from your favorites."
      end
end
