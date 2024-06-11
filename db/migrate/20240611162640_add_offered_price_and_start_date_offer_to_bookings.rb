class AddOfferedPriceAndStartDateOfferToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :offered_price, :decimal
    add_column :bookings, :start_date_offer, :date
  end
end
