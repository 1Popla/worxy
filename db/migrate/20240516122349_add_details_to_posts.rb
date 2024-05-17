class AddDetailsToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :price, :decimal
    add_column :posts, :availability, :string
    add_column :posts, :contact_information, :string
  end
end
