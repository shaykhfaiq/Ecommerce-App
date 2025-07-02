class AddDetailsToBuyerProfiles < ActiveRecord::Migration[7.2]
  def change
    change_table :buyer_profiles do |t|
      t.string :gender
      t.date :date_of_birth
      t.string :city
      t.string :country
      t.string :postal_code
    end
  end
end
