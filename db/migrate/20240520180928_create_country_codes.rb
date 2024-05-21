class CreateCountryCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :country_codes do |t|
      t.string :name
      t.string :code
      t.string :flag

      t.timestamps
    end
  end
end
