class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :receiver
      t.string :sender
      t.text :message

      t.timestamps
    end
  end
end
