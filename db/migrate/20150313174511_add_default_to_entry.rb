class AddDefaultToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :isdefault, :boolean, :default => false
  end
end
