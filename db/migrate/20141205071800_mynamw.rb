class Mynamw < ActiveRecord::Migration
  def change
    rename_column :receivers, :receiver_id, :receiver_email
  end
end
