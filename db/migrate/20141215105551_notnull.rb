class Notnull < ActiveRecord::Migration

  def change

    change_column :emails, :is_draft, :boolean, :null => false, :default => true

  end

end
