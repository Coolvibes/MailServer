class Makedraft < ActiveRecord::Migration
  def change

    add_column :emails, :is_draft, :boolean

  end
end
