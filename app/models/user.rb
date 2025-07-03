class User < ApplicationRecord
  rolify
  has_one_attached :avatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :seller_profile, dependent: :destroy
  has_one :buyer_profile, dependent: :destroy

  

  def buyer?
    has_role?(:buyer)
  end

  def seller?
    has_role?(:seller)
  end

  def avatar_or_default
    avatar.attached? ? avatar : 'default_avatar.png'
  end
end
