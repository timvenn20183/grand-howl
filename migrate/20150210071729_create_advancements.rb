class CreateAdvancements < ActiveRecord::Migration
  def change
    create_table :advancements do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
  end
end
