class AddDefaultToIsActiveInProducts < ActiveRecord::Migration[7.2]
  def change
  change_column_default :products, :is_active, from: nil, to: true
  end

end
