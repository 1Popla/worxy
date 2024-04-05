class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.integer :conversation_id, null: false
      t.integer :user_id, null: false
      t.text :body, null: false

      t.timestamps
    end

    add_index :messages, :conversation_id
    add_index :messages, :user_id
  end
end
