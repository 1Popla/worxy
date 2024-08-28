class AddFinalPriceToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :final_price, :decimal
  end
end
