class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Rolify
  rolify

  # Associations
  has_one :seller_profile, dependent: :destroy
  has_one :buyer_profile, dependent: :destroy
  has_one_attached :avatar

  # Callbacks
  after_create :assign_default_role, :create_buyer_profile

  # Methods
  def assign_default_role
    self.add_role(:buyer) if self.roles.blank?
  end

  def create_buyer_profile
    self.create_buyer_profile!
  end

  def seller?
    has_role?(:seller)
  end

  def buyer?
    has_role?(:buyer)
  end

  def avatar_or_default
    avatar.attached? ? avatar : 'default_avatar.png'
  end
end
