class AddPriceOfferAndStartDateOfferToNotifications < ActiveRecord::Migration[7.1]
  def change
    add_column :notifications, :price_offer, :decimal
    add_column :notifications, :start_date_offer, :date
  end
end
