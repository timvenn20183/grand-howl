class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :name
      t.string :slug
      t.integer :category_id
      t.text :description, :limit => 16777215
      t.text :outcome, :limit => 16777215
      t.text :instructions, :limit => 16777215
      t.text :other, :limit => 16777215
      t.text :resources, :limit => 16777215
      t.text :story, :limit => 16777215
      t.text :song, :limit => 16777215
      t.text :play, :limit => 16777215
      t.integer :user_id
      t.integer :cattype_id
      t.integer :badge_id
      t.integer :advancement_id
      t.integer :time
      t.string :options
      t.text :searchtext, :limit => 16777215

      t.timestamps null: false
    end
  end
end
