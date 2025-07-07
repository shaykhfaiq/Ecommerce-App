class AddDefaultToSellerProfileStatus < ActiveRecord::Migration[7.2]
  def change
  change_column_default :seller_profiles, :status, from: nil, to: 0
end

end
