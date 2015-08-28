class AddScouterToEventscouters < ActiveRecord::Migration
  def change
    add_column :eventscouters, :scouter_id, :integer
  end
end
