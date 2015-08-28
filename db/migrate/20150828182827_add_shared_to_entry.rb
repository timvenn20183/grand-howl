class AddSharedToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :shared, :boolean, :default => true
  end
end
