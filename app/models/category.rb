class Category < ApplicationRecord
  has_many :products, dependent: :nullify

  validates :name, :slug, presence: true
  validates :slug, uniqueness: true

  before_validation :generate_slug, if: -> { slug.blank? && name.present? }

  private

  def generate_slug
    self.slug = name.parameterize
  end
end
