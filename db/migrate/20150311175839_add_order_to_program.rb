class AddOrderToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :entryorder, :text
  end
end
