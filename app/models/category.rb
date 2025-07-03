# app/models/category.rb
class Category < ApplicationRecord
  belongs_to :seller_profile

  has_many :products, dependent: :nullify

  validates :name, :slug, :seller_profile_id, presence: true
  validates :slug, uniqueness: true

  before_validation :generate_slug, if: -> { slug.blank? && name.present? }

  private

  def generate_slug
    self.slug = name.parameterize
  end
end
