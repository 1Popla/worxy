class AddProfileFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :description, :text
    add_column :users, :skills, :string
    add_column :users, :location, :string
    add_column :users, :experience, :string
  end
end
