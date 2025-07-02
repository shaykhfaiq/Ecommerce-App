class SellerProfile < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy

  validates :store_name, :store_slug, :business_email, :phone_number, presence: true
  validates :business_email, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum status: { active: 0, suspended: 1, pending: 2 }
end
