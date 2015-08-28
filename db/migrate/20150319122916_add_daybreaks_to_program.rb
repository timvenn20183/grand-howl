class AddDaybreaksToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :daybreaks, :text
  end
end
