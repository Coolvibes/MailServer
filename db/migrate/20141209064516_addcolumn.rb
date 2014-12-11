class Addcolumn < ActiveRecord::Migration
  def change
    add_column :receivers, :is_read, :boolean
  end
end
