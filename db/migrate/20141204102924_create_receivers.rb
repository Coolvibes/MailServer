class CreateReceivers < ActiveRecord::Migration
  def change
    create_table :receivers do |t|
      t.integer :email_id
      t.string :receiver_id

      t.timestamps
    end
  end
end
