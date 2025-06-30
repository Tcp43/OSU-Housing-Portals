# Created 11/18/2024 by Koury Harmon: Controller for all listing functionality

class ListingsController < ApplicationController
  # Edited 12/1/2024 by Yuxi Lin
  # Make sure user can only edit the property that belongs to them.
  before_action :set_listing, only: [ :edit, :destroy, :edit_step1, :save_step1, :edit_step2, :save_step2, :edit_step3, :save_step3, :edit_step4, :save_step4, :edit_step5, :save_step5, :toggle_status ]

  # GET /listings or /listings.json
  def index
    redirect_to student_search_path
  end

  # GET /listings/1 or /listings/1.json
  def show
    @listing = Listing.find_by(id: params[:id])
  end

  # GET /listings/1/edit
  def edit
    redirect_to edit_step1_listing_path(@listing)
  end


  # DELETE /listings/1 or /listings/1.json
  def destroy
    @listing.destroy!

    respond_to do |format|
      format.html { redirect_to listings_path, status: :see_other, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # Created 11/30/2024 by Yuxi Lin
  # Controller for create a new listing

  def new
    @listing = current_user.listings.build
  end
  def create
    # Assigns the current_user.id to the new listing's user_id
    @listing = current_user.listings.build(listing_params)

    if params[:listing][:name].blank?
      flash[:alert] = "Name can't be blank"
      redirect_to new_listing_path
    elsif @listing.save
      redirect_to edit_step1_listing_path(@listing)
    else
      redirect_to new_listing_path
    end
  end

  # Step1: Address
  def edit_step1
  end
  def save_step1
    if params[:listing][:address].blank? || params[:listing][:city].blank? || params[:listing][:state].blank? || params[:listing][:zip].blank?|| params[:listing][:property_type].blank?
      flash[:alert] = "Street Address or City or State or Zip or Property Type can't be blank"
      redirect_to edit_step1_listing_path(@listing)
    elsif @listing.update(listing_params)
      if params[:exit]
        redirect_to landlord_profile_path(current_user)
      else
        redirect_to edit_step2_listing_path(@listing)
      end
    else
      redirect_to edit_step1_listing_path(@listing)
    end
  end

  # Step2: Property Info
  def edit_step2
  end
  def save_step2
    if params[:listing][:amenities].present?
      @listing.amenities = params[:listing][:amenities].join(", ")
    end
    if params[:listing][:bedroom].blank? || params[:listing][:bathroom].blank?
      flash[:alert] = "Number of bedrooms or Number of bathrooms can't be blank"
      redirect_to edit_step2_listing_path(@listing)
    elsif @listing.update(listing_params)
      if params[:exit]
        redirect_to landlord_profile_path(current_user)
      else
        redirect_to edit_step3_listing_path(@listing)
      end
    else
      redirect_to edit_step2_listing_path(@listing)
    end
  end

  # Step 3: Pricing
  def edit_step3
  end
  def save_step3
    # Check if rent_price and security_deposit are provided
    if params[:listing][:rent_price].blank? || params[:listing][:security_deposit].blank?
      flash[:alert] = "Rent price and security deposit can't be blank"
      redirect_to edit_step3_listing_path(@listing) and return
    end

    # Ensure that rent_price and security_deposit are valid numbers
    if params[:listing][:rent_price].to_f <= 0 || params[:listing][:security_deposit].to_f <= 0
      flash[:alert] = "Rent price and security deposit must be positive numbers"
      redirect_to edit_step3_listing_path(@listing) and return
    end
    if @listing.update(listing_params)
      if params[:exit]
        redirect_to landlord_profile_path(current_user)
      else
        redirect_to edit_step4_listing_path(@listing)
      end
    else
      flash[:alert] = "There was an issue updating the pricing information. Please check your inputs."
      redirect_to edit_step3_listing_path(@listing)
    end
  end

  # Step 4: Lease
  def edit_step4
  end
  def save_step4
    # Update lease information
    if @listing.update(listing_params)
      if params[:next]
        redirect_to edit_step5_listing_path(@listing)
      elsif params[:exit]
        redirect_to landlord_profile_path(current_user)
      else
        redirect_to edit_step4_listing_path(@listing)
      end
    else
      flash[:alert] = "There was an error saving your lease information."
      redirect_to edit_step4_listing_path(@listing)
    end
  end

  # Step 5: Contact info
  def edit_step5
  end
  def save_step5
    if @listing.update(listing_params.merge(status: "posted"))
      flash[:success] = "Your listing has been posted successfully."
      redirect_to listing_path(@listing)
    else
      flash[:error] = "There was an error updating the listing: #{@listing.errors.full_messages.to_sentence}"
      redirect_to edit_step5_listing_path(@listing)
    end
  end

  def toggle_status
    new_status = @listing.status == "posted" ? "unposted" : "posted"
    if @listing.update(status: new_status)
      redirect_to @listing, notice: "Listing status updated successfully."
    else
      redirect_to @listing, alert: "Failed to update the status."
    end
  end

  private
    # Created 12/1/2024 by Yuxi Lin: Action before edits to make sure only listing owner can edit
    # Edited 12/2/2024 by Kathir Maarikarthykeyan: Allowed students and admins to view any listing
    # Only allow user to get access to their listings.
    def set_listing
      if current_user.role == "admin" || current_user.role == "manager"
        @listing = Listing.find_by(id: params[:id])
      else
        @listing = current_user.listings.find_by(id: params[:id])
      end

      unless @listing
        redirect_to listings_path, alert: "You are not authorized to edit this listing."
      end
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      params.require(:listing).permit(
        :address, :unit, :city, :state, :zip, :property_type,
        :bedroom, :bathroom, :description, :rent_price, :available,
        :landlord_id, :security_deposit, :name, :square_footage,
        :move_in_date, :lease_terms, :pets_allowed, :amenities,
        :contact_first_name, :contact_last_name, :contact_email,
        :contact_phone, :status, :cover_image
      )
    end
end
