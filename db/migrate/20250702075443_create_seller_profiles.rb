class CreateSellerProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :seller_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :store_name
      t.string :store_slug
      t.string :business_email
      t.string :phone_number
      t.text :address
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.text :description
      t.string :logo_url
      t.string :banner_url
      t.string :website
      t.string :tax_id
      t.boolean :verified
      t.integer :status

      t.timestamps
    end
  end
end
