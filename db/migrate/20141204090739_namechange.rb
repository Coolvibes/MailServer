class Namechange < ActiveRecord::Migration
  def change
    rename_column :emails, :receiver, :subject
  end
end
