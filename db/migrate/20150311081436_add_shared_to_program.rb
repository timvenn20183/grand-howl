class AddSharedToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :shared, :boolean, :default => false
  end
end
