class AddViewsToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :views, :integer
  end
end
