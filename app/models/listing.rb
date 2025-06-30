# Created 11/18/2024 by Koury Harmon
# Edited 11/21/2024 by Koury Harmon: added relations between user and listing
class Listing < ApplicationRecord
  belongs_to :user, foreign_key: "landlord_id"
  has_many :favorites, dependent: :destroy
  has_many :favorited_by, through: :favorites, source: :user
  has_one_attached :cover_image # For a single cover image per listing

    # Created 11/30/2024 by Yuxi Lin
    # Validation for 'Posted' status
    validate :required_fields_for_posted_status, if: :posted?

    private

    def posted?
      status == "Posted"
    end

    def required_fields_for_posted_status
      # Validate presence of required fields
      required_fields = [
        :address, :bedroom, :bathroom, :description, :rent_price,
        :name, :city, :state, :zip, :property_type,
        :move_in_date, :lease_terms, :contact_first_name,
        :contact_last_name, :contact_email, :contact_phone
      ]

      required_fields.each do |field|
        errors.add(field, "can't be blank") if self.send(field).blank?
      end

      # Additional validation for fields where specific formats are needed
      validate_email_format
    end

    def validate_email_format
      if contact_email.present? && !contact_email.match(/\A[^@\s]+@[^@\s]+\z/)
        errors.add(:contact_email, "is not a valid email")
      end
    end
end
