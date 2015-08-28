class AddViewlinkedToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :viewlinked, :boolean, :default => true
  end
end
