class AddVenueToComment < ActiveRecord::Migration
  def change
    add_column :comments, :venue_id, :integer
  end
end
