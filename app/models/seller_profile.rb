# app/models/seller_profile.rb
class SellerProfile < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy
  has_many :categories, dependent: :destroy

  enum status: { active: 0, suspended: 1, pending: 2 }
end
