class AddIncludeInChartToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :include_in_chart, :boolean
  end
end
