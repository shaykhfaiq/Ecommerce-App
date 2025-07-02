class CreateBuyerProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :buyer_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :phone
      t.string :address

      t.timestamps
    end
  end
end
