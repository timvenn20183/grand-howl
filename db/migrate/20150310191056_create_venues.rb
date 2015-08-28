class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :slug
      t.boolean :is_camp
      t.boolean :is_day
      t.text :description,  :limit => 16777215
      t.text :activities,  :limit => 16777215
      t.text :pros,  :limit => 16777215
      t.text :cons, :limit => 16777215
      t.integer :user_id
      t.string :image

      t.timestamps null: false
    end
  end
end
