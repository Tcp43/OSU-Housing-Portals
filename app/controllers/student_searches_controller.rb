# Created by Kathir Maarikarthykeyan 11/22/24: Search functionality for house options
# Edited by Kathir Maarikarthykeyan 11/24/24: Show all listings (index route only)
# Edited by Kathir Maarikarthykeyan 11/28/24: Add conditionals to filter listing objects in db
# Edited by Kathir Maarikarthykeyan 12/1/24: Added pagination using kaminari gem
# Edited by Kathir Maarikarthykeyan 12/4/24: Finalized filters for submission
class StudentSearchesController < ApplicationController
  def student_search
    # Only include listings with 'posted' status for students
    if current_user.role == "student"
      @listings = Listing.where(status: "posted")
    else
      @listings = Listing.all
    end

    # Search by address or location
    if params[:search].present?
      @listings = @listings.where("address LIKE ? OR city LIKE ? OR state LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    # Filter by bedrooms
    if params[:bedroom].present?
      if params[:bedroom].include?("5+")
        exact_bedrooms = Array.wrap(params[:bedroom]) - [ "5+" ]
        @listings = @listings.where("bedroom IN (?) OR bedroom >= ?", exact_bedrooms, 5)
      else
        @listings = @listings.where(bedroom: params[:bedroom])
      end
    end

    # Filter by bathrooms
    if params[:bathroom].present?
      if params[:bathroom].include?("4+")
        exact_baths = Array.wrap(params[:bathroom]) - [ "4+" ]
        @listings = @listings.where("bathroom IN (?) OR bathroom >= ?", exact_baths, 4)
      else
        @listings = @listings.where(bathroom: params[:bathroom])
      end
    end

    # Filter by rent range if parameters are provided
    if params[:min_rent].present? && params[:max_rent].present?
      @listings = @listings.where(rent_price: params[:min_rent]..params[:max_rent])
    elsif params[:min_rent].present?
      @listings = @listings.where("rent_price >= ?", params[:min_rent])
    elsif params[:max_rent].present?
      @listings = @listings.where("rent_price <= ?", params[:max_rent])
    end

    # Filter by amenities
    if params[:amenities].present?
      params[:amenities].each do |amenity|
        @listings = @listings.where(amenity => true)
      end
    end

    # Filter by house type
    if params[:property_type].present?
      @listings = @listings.where(property_type: params[:property_type])
    end

    # Apply pagination
    @listings = @listings.page(params[:page]).per(12)
  end
end
