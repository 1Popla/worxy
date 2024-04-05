class AddVisibleToUserIdToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :visible_to_user_id, :integer
  end
end