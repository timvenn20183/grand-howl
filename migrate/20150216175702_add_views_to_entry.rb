class AddViewsToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :views, :integer, :default => 0
  end
end
