class Product < ApplicationRecord
  belongs_to :seller_profile
  belongs_to :category

  has_many_attached :images

  validates :title, :description, :price, :stock, :sku, presence: true
  validates :sku, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_validation :generate_unique_sku, on: :create

  scope :active, -> { where(is_active: true) }

  private

  def generate_unique_sku
    return if self.sku.present?

    begin
      self.sku = "ALM-#{SecureRandom.hex(4).upcase}"
    end while self.class.exists?(sku: sku)
  end
end
