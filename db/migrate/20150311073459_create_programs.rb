class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :name
      t.string :theme
      t.string :duty_six
      t.integer :user_id
      t.integer :venue_id
      t.string :slug
      t.timestamps null: false
    end
  end
end
