class CreateEventscouters < ActiveRecord::Migration
  def change
    create_table :eventscouters do |t|
      t.integer :entry_id
      t.integer :program_id

      t.timestamps null: false
    end
  end
end
