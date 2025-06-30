# Created 11/20/2024 by Troy Paschal: Validates user roles
# Edited 11/28/2024 by Troy Paschal: Defines associations for favorites
# Edited 11/28/2024 by Yuxi Lin: Add devise confirmable

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable

  # Created 11/24/2024 by Yuxi Lin: Valid roles
  ROLES = %w[student manager admin landlord]
  # Validating that role is one of the valid roles
  validates :role, inclusion: { in: ROLES }

  # Created 11/23/2024 by Troy Paschal: Defines associations
  has_many :favorites, dependent: :destroy
  has_many :favorite_listings, through: :favorites, source: :listing
  has_many :listings, foreign_key: "landlord_id", dependent: :destroy

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id", dependent: :destroy

  # Created 11/23/2024 by Yuxi Lin: add user's data validations.
  validates :name, presence: true, length: { maximum: 50 }, format: { with: /\A[\w ]+\z/, message: "only allows letters, numbers, spaces, and underscores" }

  # Methods to check roles
  def student?
    role == "student"
  end

  def landlord?
    role == "landlord"
  end

  def admin?
    role == "admin"
  end

  def manager?
    role == "manager"
  end
end
