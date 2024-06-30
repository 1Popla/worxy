class CreateOpinions < ActiveRecord::Migration[6.1]
  def change
    create_table :opinions do |t|
      t.integer :rater_id, null: false, foreign_key: {to_table: :users}
      t.integer :ratee_id, null: false, foreign_key: {to_table: :users}
      t.integer :stars, null: false
      t.text :comment, null: false

      t.timestamps
    end
    add_index :opinions, :rater_id
    add_index :opinions, :ratee_id
  end
end
