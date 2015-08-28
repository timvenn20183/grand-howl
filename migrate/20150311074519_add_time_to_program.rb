class AddTimeToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :runtime, :integer
  end
end
