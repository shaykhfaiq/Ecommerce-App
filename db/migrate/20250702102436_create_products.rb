class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.references :seller_profile, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :stock
      t.string :sku
      t.boolean :is_active

      t.timestamps
    end
  end
end
