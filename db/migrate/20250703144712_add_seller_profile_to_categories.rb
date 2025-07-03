class AddSellerProfileToCategories < ActiveRecord::Migration[7.2]
  def change
    add_reference :categories, :seller_profile, null: false, foreign_key: true
  end
end
