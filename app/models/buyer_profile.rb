class BuyerProfile < ApplicationRecord
  belongs_to :user

  validates :phone, :address, :city, :country, presence: true
  validates :gender, inclusion: { in: %w[male female other], allow_blank: true }

  def full_address
    [address, city, postal_code, country].compact.join(', ')
  end
end
