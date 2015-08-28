class AddCustomTimeToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :entrytime, :text
  end
end
