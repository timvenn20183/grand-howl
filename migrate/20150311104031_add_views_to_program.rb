class AddViewsToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :views, :integer
  end
end
