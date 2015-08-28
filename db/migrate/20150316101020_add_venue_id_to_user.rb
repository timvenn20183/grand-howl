class AddVenueIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :venue_id, :integer
    add_column :users, :program_color, :string
    add_column :users, :program_day, :integer
    add_column :users, :program_time, :datetime
  end
end
