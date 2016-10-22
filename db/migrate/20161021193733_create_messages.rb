class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body, index: true
      t.integer :sender_id, index: true
      t.integer :recipient_id, index: true
      t.datetime :read_at
      t.integer :status

      t.timestamps
    end
  end
end
